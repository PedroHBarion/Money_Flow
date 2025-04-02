import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app_money_flow/src/core/models/transaction.dart';
import 'package:app_money_flow/src/core/services/expense_service.dart';

class ExpensesController extends ChangeNotifier {
  int currentMonthIndex = 0;
  List<PieChartSectionData> chartData = [];
  List<Transaction> transactions = [];

  final ExpenseService _expenseService = ExpenseService();

  void updateMonth(int newIndex) {
    currentMonthIndex = newIndex;
    fetchDataForMonth(newIndex); // Atualiza os dados com o novo mês
    notifyListeners(); // Notifica os widgets que dependem desse controller
  }

  ExpensesController() {
    fetchDataForMonth(currentMonthIndex);
  }

  void fetchDataForMonth(int monthIndex) async {
    try {
      List<Transaction> fetchedTransactions =
          await _expenseService.fetchTransactions();
      transactions = fetchedTransactions;
      chartData = _generateChartData(monthIndex);
      notifyListeners();
    } catch (e) {
      print("Erro ao carregar transações: $e");
    }
  }

  List<PieChartSectionData> _generateChartData(int monthIndex) {
    Map<String, double> categoryTotals = {};
    for (var transaction in transactions) {
      if (transaction.date.month == monthIndex + 1) {
        categoryTotals[transaction.category] =
            (categoryTotals[transaction.category] ?? 0) + transaction.value;
      }
    }
    return categoryTotals.entries
        .map(
          (entry) => PieChartSectionData(
            color: _getCategoryColor(entry.key),
            value: entry.value,
            radius: 30,
            showTitle: true,
            title: '${entry.key}\nR\$ ${entry.value.toStringAsFixed(2)}',
            titlePositionPercentageOffset: 2.5,
            titleStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _getCategoryColor(entry.key),
            ),
          ),
        )
        .toList();
  }

  Transaction? getHighestTransactionForMonth(int monthIndex) {
    // Filtra as transações do mês selecionado
    List<Transaction> filteredTransactions =
        transactions
            .where((transaction) => transaction.date.month == monthIndex + 1)
            .toList();

    // Se não houver transações no mês, retorna null
    if (filteredTransactions.isEmpty) return null;

    // Retorna a transação com o maior valor
    return filteredTransactions.reduce((a, b) => a.value > b.value ? a : b);
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Roupas':
        return Colors.red;
      case 'Educação':
        return Colors.green;
      case 'Gasolina':
        return Colors.purple;
      case 'Compras Online':
        return Colors.orange;
      case 'Varejo':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
