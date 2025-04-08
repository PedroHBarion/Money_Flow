import 'package:flutter/material.dart';
import '../../../../core/models/transactions/transaction.dart';
import '../../../../core/services/transactions_service.dart';
// import '../../../../core/models/transactions/transaction_filters_model.dart';

class TransactionsController extends ChangeNotifier {
  final TransactionService service;

  List<TransactionModel> transactions = [];
  bool isLoading = false;
  String? selectedAccount;
  int? selectedYear;
  int currentMonthIndex = DateTime.now().month - 1;

  TransactionsController({required this.service});

  Future<void> fetchTransactions() async {
    isLoading = true;
    notifyListeners();

    try {
      transactions = await service.getAll(month: currentMonthIndex, year: 2025);

      // Debug aqui 👇
      for (var tx in transactions) {
        print(
            'Tipo: ${tx.category?.icon}, Subcategoria: ${tx.category?.name}, Ícone: ${tx.category?.id}');
      }
    } catch (e) {
      print('Erro ao buscar transações: $e'); // sem o \$ no print
    }

    isLoading = false;
    notifyListeners();
  }

  void setAccount(String? account) {
    selectedAccount = account;
    fetchTransactions();
  }

  void setYear(int? year) {
    selectedYear = year;
    fetchTransactions();
  }

  void changeMonth(int newIndex) {
    currentMonthIndex = newIndex;

    if (currentMonthIndex < 0) currentMonthIndex += 12;
    fetchTransactions();
    notifyListeners();
  }
}

