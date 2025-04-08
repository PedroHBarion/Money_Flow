// lib/ui/pages/home/controller/account_balance_controller.dart

import 'package:flutter/material.dart';
import '../../../../core/models/bank_accounts/bank_account_model.dart';
import '../../../../core/services/bank_accounts_service.dart';


class AccountsController extends ChangeNotifier {
  final BankAccountsService service;

  AccountsController({required this.service});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isHidden = false;
  bool get isHidden => _isHidden;

  List<BankAccountModel> _accounts = [];
  List<BankAccountModel> get accounts => _accounts;

  double get totalBalance {
    return _accounts.fold(0.0, (sum, acc) => sum + acc.currentBalance);
  }

  Future<void> loadAccounts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _accounts = await service.getAll();
    } catch (e) {
      print('Erro ao carregar contas: $e');
      _accounts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleHidden() {
    _isHidden = !_isHidden;
    notifyListeners();
  }
}
