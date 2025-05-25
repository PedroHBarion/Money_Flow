import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/core/models/bank_account_model.dart';
import 'package:app_money_flow/src/core/models/category_model.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_model.dart';
import 'package:app_money_flow/src/core/services/bank_accounts_service.dart';
import 'package:app_money_flow/src/core/services/categories_service.dart';
import 'package:app_money_flow/src/core/services/transactions_service.dart';
import 'package:app_money_flow/src/core/utils/format_date.dart';
import 'package:app_money_flow/src/core/utils/show_toast.dart';
import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts_controller.dart';
import 'package:app_money_flow/src/pages/home/widgets/transactions/transactions_controller.dart';
import 'package:app_money_flow/src/app_money_flow.dart';
import 'package:intl/intl.dart';

class TransactionModalController extends ChangeNotifier {
  // Dependências
  final TransactionService _transactionService;
  final BankAccountsService _bankAccountsService;
  final CategoriesService _categoriesService;

  TransactionModalController(
    this._transactionService,
    this._bankAccountsService,
    this._categoriesService,
  );

  // Controllers de formulário
  final nameController = TextEditingController();
  final valueController = TextEditingController(text: '');
  final dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Estados do formulário
  DateTime? selectedDate;
  TransactionType? selectedType;
  String? selectedCategory;
  String? selectedAccount;

  bool isLoading = false;
  bool isDeleting = false;
  bool isFetching = false;

  TransactionModel? editingTransaction;
  bool get isEditing => editingTransaction != null;

  List<CategoryModel> categories = [];
  List<BankAccountModel> accounts = [];

  // Inicialização do modal
  Future<void> init(TransactionType selectedTypeParam) async {
    isFetching = true;
    notifyListeners();
    reset(clearEditing: false);
    selectedType = selectedTypeParam;

    try {
      await Future.wait([
        _fetchCategories(selectedTypeParam),
        _fetchBankAccounts(),
      ]);
    } catch (e) {
      Toast.error('Erro ao carregar dados iniciais');
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }

  Future<void> _fetchCategories(TransactionType type) async {
    categories = await _categoriesService.getAll(type: type);
  }

  Future<void> _fetchBankAccounts() async {
    accounts = await _bankAccountsService.getAll();
  }

  // Carregar dados para edição
  void loadTransactionToEdit(TransactionModel transaction) {
    editingTransaction = transaction;
    nameController.text = transaction.name;
    valueController.text = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: '',
      decimalDigits: 2,
    ).format(transaction.value).trim();
    selectedType = transaction.type;
    selectedCategory = transaction.categoryId;
    selectedAccount = transaction.bankAccountId;
    selectedDate = DateTime.parse(transaction.date);
    dateController.text = formatDate(transaction.date);
    notifyListeners();
  }

  // Submissão (criação/edição)
  Future<bool> submit(VoidCallback onSuccess) async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid ||
        selectedCategory == null ||
        selectedAccount == null ||
        selectedDate == null) {
      if (selectedCategory == null) Toast.error('Selecione uma categoria');
      if (selectedAccount == null) Toast.error('Selecione uma conta bancária');
      if (selectedDate == null) Toast.error('Selecione uma data');
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      final payload = TransactionModel(
        id: editingTransaction?.id,
        name: nameController.text,
        value: _currencyToDouble(valueController.text),
        type: selectedType!,
        categoryId: selectedCategory,
        bankAccountId: selectedAccount!,
        date: selectedDate!.toIso8601String(),
      );

      if (isEditing) {
        await _transactionService.update(payload);
        Toast.success('Transação atualizada com sucesso!');
      } else {
        await _transactionService.create(payload);
        Toast.success('Transação criada com sucesso!');
      }

      onSuccess();
      GetIt.I<TransactionsController>().fetchTransactions();
      GetIt.I<AccountsController>().loadAccounts();

      reset();
      return true;
    } catch (e) {
      Toast.error(isEditing
          ? 'Erro ao editar a transação!'
          : 'Erro ao criar a transação!');
      debugPrint('Erro no submit: $e');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Métodos utilitários e setters
  double _currencyToDouble(String value) {
    return double.tryParse(value.replaceAll('.', '').replaceAll(',', '.')) ??
        0.0;
  }

  void setCategory(String value) {
    if (selectedCategory == value) return;
    selectedCategory = value;
    notifyListeners();
  }

  void setAccount(String value) {
    if (selectedAccount == value) return;
    selectedAccount = value;
    notifyListeners();
  }

  void setType(TransactionType? type) {
    if (selectedType == type) return;
    selectedType = type;
    notifyListeners();
  }

  void reset({bool clearEditing = true}) {
    if (clearEditing) editingTransaction = null;
    nameController.clear();
    valueController.text = '';
    selectedCategory = null;
    selectedAccount = null;
    selectedDate = null;
    dateController.clear();
    notifyListeners();
  }

  // Exclusão da transação
  Future<void> deleteTransaction(
      BuildContext context, String transactionId) async {
    isDeleting = true;
    notifyListeners();

    try {
      await _transactionService.remove(transactionId);

      Toast.success(selectedType?.label == 'EXPENSE'
          ? 'Despesa excluída com sucesso!'
          : 'Receita excluída com sucesso!');

      await GetIt.I<TransactionsController>().fetchTransactions();
      await GetIt.I<AccountsController>().loadAccounts();

      navigatorKey.currentState?.pop();
    } catch (e) {
      Toast.error(selectedType?.label == 'EXPENSE'
          ? 'Erro ao excluir a despesa!'
          : 'Erro ao excluir a receita!');
      debugPrint('Erro ao excluir transação: $e');
    } finally {
      isDeleting = false;
      notifyListeners();
    }
  }

  // Descarte dos controllers
  @override
  void dispose() {
    nameController.dispose();
    valueController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
