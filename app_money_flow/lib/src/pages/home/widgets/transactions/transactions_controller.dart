import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_filters_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/models/transactions/transaction_model.dart';
import '../../../../core/services/transactions_service.dart';

class TransactionsController extends ChangeNotifier {
  final TransactionService service;

  List<TransactionModel> transactions = [];
  bool isLoading = false;

  int currentMonthIndex = DateTime.now().month - 1;
  // filtros
  String? selectedBankAccountId;
  int? selectedYear = 2025;
  TransactionType? selectedType;

  // Filtros temporários
  String? tempAccount;
  int? tempYear;

  TransactionsController({required this.service});

  Future<void> fetchTransactions() async {
    isLoading = true;
    notifyListeners();

    try {
      final filters = TransactionFiltersModel(
          month: currentMonthIndex,
          year: selectedYear!,
          type: selectedType?.value,
          bankAccountId: selectedBankAccountId);
      transactions = await service.getAll(filters);
    } catch (e) {
      debugPrint('Erro ao buscar transações: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setAccount(String? account) {
    selectedBankAccountId = account;
    fetchTransactions();
  }

  // Aplicar filtros
  Future<void> applyFilters() async {
    selectedBankAccountId = tempAccount;
    selectedYear = tempYear ?? DateTime.now().year;
    await fetchTransactions();
  }

  // Set temporário
  void setTempAccount(String? account) => tempAccount = account;
  void setTempYear(int? year) => tempYear = year;

  // Limpar filtros
  Future<void> clearFilters() async {
    tempAccount = null;
    tempYear = DateTime.now().year;

    selectedBankAccountId = null;
    selectedYear = DateTime.now().year;

    await fetchTransactions();
  }

  Future<void> changeMonth(int newIndex) async {
    currentMonthIndex = newIndex;

    if (currentMonthIndex < 0) currentMonthIndex += 12;
    await fetchTransactions();
    notifyListeners();
  }

  Future<void> setTransactionType(TransactionType? type) async {
    selectedType = type;
    await fetchTransactions();
  }
}
