import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_money_flow/src/core/models/bank_account_model.dart';
import 'package:app_money_flow/src/core/services/bank_accounts_service.dart';
import 'package:app_money_flow/src/core/utils/show_toast.dart';
import 'package:app_money_flow/src/core/enums/bank_acount_type.dart';
import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts_controller.dart';
import 'package:app_money_flow/src/pages/home/widgets/transactions/transactions_controller.dart';
import 'package:app_money_flow/src/app_money_flow.dart';

class AccountModalController extends ChangeNotifier {
  // Dependências
  final BankAccountsService _service;

  AccountModalController(this._service);

  // Controllers e Chaves de Formulário
  final nameController = TextEditingController();
  final initialBalanceController = TextEditingController(text: '0,00');
  final formKey = GlobalKey<FormState>();

  // Estados do formulário
  BankAccountType? selectedType = BankAccountType.checking;
  String? selectedColor;

  bool isLoading = false;
  bool isDeleting = false;

  BankAccountModel? editingAccount;
  bool get isEditing => editingAccount != null;

  // Manipulação de dados
  void loadAccountToEdit(BankAccountModel account) {
    editingAccount = account;
    nameController.text = account.name;
    initialBalanceController.text =
        account.initialBalance.toStringAsFixed(2).replaceAll('.', ',');
    selectedType = BankAccountType.fromString(account.type);
    selectedColor = account.color;
    notifyListeners();
  }

  double _currencyToDouble(String value) {
    return double.tryParse(value.replaceAll('.', '').replaceAll(',', '.')) ??
        0.0;
  }

  void setColor(String value) {
    if (selectedColor == value) return;
    selectedColor = value;
    notifyListeners();
  }

  void setType(BankAccountType? type) {
    if (selectedType == type) return;
    selectedType = type;
    notifyListeners();
  }

  void reset() {
    editingAccount = null;
    nameController.clear();
    initialBalanceController.text = '0,00';
    selectedType = BankAccountType.checking;
    selectedColor = null;
    notifyListeners();
  }

  // Submissão do formulário (criação / edição)
  Future<bool> submit(VoidCallback onSuccess) async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid || selectedColor == null || selectedType == null) {
      if (selectedColor == null) Toast.error('Informe a cor');
      if (selectedType == null) Toast.error('Informe o tipo da conta');
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      final payload = BankAccountModel(
        id: editingAccount?.id,
        name: nameController.text,
        initialBalance: _currencyToDouble(initialBalanceController.text),
        type: selectedType!.value,
        color: selectedColor!,
      );

      if (isEditing) {
        await _service.update(payload);
        Toast.success('Conta atualizada com sucesso!');
      } else {
        await _service.create(payload);
        Toast.success('Conta criada com sucesso!');
      }

      onSuccess();
      GetIt.I<AccountsController>().loadAccounts();
      reset();
      return true;
    } catch (e) {
      Toast.error(
          isEditing ? 'Erro ao editar a conta!' : 'Erro ao criar a conta!');
      debugPrint('Erro: $e');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Exclusão da conta
  Future<void> deleteAccount(BuildContext context, String accountId) async {
    isDeleting = true;
    notifyListeners();

    try {
      await _service.remove(accountId);

      Toast.success('Conta excluída com sucesso!');

      await GetIt.I<TransactionsController>().fetchTransactions();
      await GetIt.I<AccountsController>().loadAccounts();

      navigatorKey.currentState?.pop();
    } catch (e) {
      Toast.error('Erro ao excluir a conta!');
      debugPrint('Erro ao excluir conta: $e');
    } finally {
      isDeleting = false;
      notifyListeners();
    }
  }

  // Descarte dos controllers
  @override
  void dispose() {
    nameController.dispose();
    initialBalanceController.dispose();
    super.dispose();
  }
}
