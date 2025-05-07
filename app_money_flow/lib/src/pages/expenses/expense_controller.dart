import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/core/models/bank_account_model.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_model.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_by_category_model.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_filters_model.dart';
import 'package:app_money_flow/src/core/services/bank_accounts_service.dart';
import 'package:app_money_flow/src/core/services/transactions_service.dart';
import 'package:app_money_flow/src/core/services/message_service.dart'; // <-- Importando o MessageService
import 'package:app_money_flow/src/core/utils/hex_to_color.dart';

class ExpensesController extends ChangeNotifier {
  final TransactionService transactionService;
  final BankAccountsService bankAccountsService;
  final MessageService messageService; // <-- Adicionando o MessageService

  ExpensesController(
      this.transactionService, this.bankAccountsService, this.messageService);

  // Estado de data selecionada
  int currentMonthIndex = DateTime.now().month - 1;
  int selectedYear = DateTime.now().year;

  // Dados carregados
  List<TransactionModel> transactions = [];
  List<TransactionByCategoryModel> transactionByCategory = [];
  List<BankAccountModel> accounts = [];
  String?
      categoryMessage; // <-- Variável para armazenar a mensagem da categoria

  // Estados de carregamento
  bool isLoading = false;
  bool isLoadingAccounts = false;

  /// Carrega transações para o mês/ano selecionado
  Future<void> loadTransactions() async {
    isLoading = true;
    notifyListeners();

    try {
      final filters = TransactionFiltersModel(
        month: currentMonthIndex,
        year: selectedYear,
      );

      await loadBankAccounts();
      transactions = await transactionService.getAll(filters);
      await loadCategoryMessage(); // <-- Carregar a mensagem da categoria mais gasta
    } catch (_) {
      // Erros podem ser tratados de forma mais robusta futuramente
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Carrega a mensagem da categoria mais gasta
  Future<void> loadCategoryMessage() async {
    final highestTransaction = getHighestTransactionForMonth();
    if (highestTransaction != null) {
      final category = highestTransaction.category?.name ?? '';
      categoryMessage = await messageService.getMessageForCategory(category);
    } else {
      categoryMessage =
          "Nenhuma despesa registrada neste mês. Que tal começar a planejar seus gastos? 💡📉";
    }
    notifyListeners();
  }

  /// Carrega resumo de despesas por categoria
  Future<void> loadTransactionByCategory() async {
    try {
      transactionByCategory =
          await transactionService.getExpenseSummaryByCategory(
        month: currentMonthIndex,
        year: selectedYear,
      );
      notifyListeners();
    } catch (_) {
      // Tratamento de erro silencioso por enquanto
    }
  }

  /// Carrega todas as contas bancárias do usuário
  Future<void> loadBankAccounts() async {
    isLoadingAccounts = true;
    notifyListeners();

    try {
      accounts = await bankAccountsService.getAll();
    } catch (_) {
      // Tratamento de erro silencioso
    } finally {
      isLoadingAccounts = false;
      notifyListeners();
    }
  }

  /// Altera o mês atual e recarrega os dados
  void changeMonth(int newIndex) {
    currentMonthIndex = newIndex % 12;
    loadTransactions();
    loadTransactionByCategory();
    notifyListeners();
  }

  /// Altera o ano selecionado e recarrega os dados
  void setYear(int year) {
    selectedYear = year;
    loadTransactions();
    loadTransactionByCategory();
  }

  /// Calcula o total de despesas do mês atual
  double totalExpenses() {
    return transactions
        .where((transaction) =>
            DateTime.tryParse(transaction.date)?.month ==
                currentMonthIndex + 1 &&
            transaction.type == TransactionType.expense)
        .fold(0.0, (sum, transaction) => sum + transaction.value);
  }

  /// Calcula o saldo total das contas bancárias
  double getTotalBalance() {
    return accounts
        .map((acc) => acc.currentBalance ?? 0.0)
        .fold(0.0, (sum, balance) => sum + balance);
  }

  /// Gera os dados de gráfico de pizza a partir das categorias
  List<PieChartSectionData> get chartData {
    return transactionByCategory.map((categoryData) {
      return PieChartSectionData(
        color: hexToColor(categoryData.color),
        value: categoryData.total,
        radius: 30,
        showTitle: true,
        title:
            '${categoryData.name}\nR\$ ${categoryData.total.toStringAsFixed(2)}',
        titlePositionPercentageOffset: 2.2,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: hexToColor(categoryData.color),
        ),
      );
    }).toList();
  }

  /// Retorna a maior transação de despesa do mês atual
  TransactionModel? getHighestTransactionForMonth() {
    final selectedMonth = currentMonthIndex;

    final expenseTransactions = transactions.where((transaction) {
      final date = DateTime.tryParse(transaction.date);
      return date != null &&
          date.month == selectedMonth + 1 &&
          transaction.type == TransactionType.expense;
    });

    return expenseTransactions.isEmpty
        ? null
        : expenseTransactions.reduce((a, b) => a.value > b.value ? a : b);
  }
}
