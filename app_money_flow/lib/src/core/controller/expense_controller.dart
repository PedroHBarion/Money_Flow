import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app_money_flow/src/core/models/transaction.dart';
import 'package:app_money_flow/src/core/services/expense_service.dart';
import 'package:app_money_flow/src/core/services/message_service.dart';

/// Controller responsável por gerenciar os dados e a lógica relacionados às despesas do usuário.
/// Ele fornece os dados para a interface, calcula estatísticas e interage com os serviços de despesas e mensagens.
class ExpensesController extends ChangeNotifier {
  /// Índice do mês atual selecionado.
  int currentMonthIndex = 0;

  /// Dados formatados para exibição no gráfico de pizza.
  List<PieChartSectionData> chartData = [];

  /// Lista de transações do usuário.
  List<Transaction> transactions = [];

  /// Mensagem personalizada com sugestões de economia baseada na categoria mais gasta.
  String highestCategoryMessage = "";

  /// Serviço responsável por buscar os dados das transações.
  final ExpenseService _expenseService = ExpenseService();

  /// Serviço responsável por gerar mensagens personalizadas para categorias de gastos.
  final MessageService _messageService = MessageService();

  /// Construtor que carrega os dados do mês atual ao inicializar.
  ExpensesController() {
    fetchDataForMonth(currentMonthIndex);
  }

  /// Atualiza o mês atual e recarrega os dados correspondentes.
  void updateMonth(int newIndex) {
    currentMonthIndex = newIndex;
    fetchDataForMonth(newIndex);
    notifyListeners();
  }

  /// Obtém os dados das transações para um determinado mês e gera os dados do gráfico.
  void fetchDataForMonth(int monthIndex) async {
    try {
      transactions = await _expenseService.fetchTransactions();
      chartData = _generateChartData(monthIndex);
      _updateHighestCategoryMessage(monthIndex);
      notifyListeners();
    } catch (e) {
      print("Erro ao carregar transações: $e");
    }
  }

  /// Atualiza a mensagem de sugestão de economia com base na categoria mais gasta do mês.
  void _updateHighestCategoryMessage(int monthIndex) async {
    String? highestCategory = _getHighestCategory(monthIndex);
    if (highestCategory != null) {
      highestCategoryMessage = await _messageService.getMessageForCategory(highestCategory);
    } else {
      highestCategoryMessage = "Nenhuma categoria com gastos este mês.";
    }
    notifyListeners();
  }

  /// Retorna a categoria com maior gasto em um determinado mês.
  String? _getHighestCategory(int monthIndex) {
    Map<String, double> categoryTotals = {};
    for (var transaction in transactions) {
      if (transaction.date.month == monthIndex + 1) {
        categoryTotals[transaction.category] =
            (categoryTotals[transaction.category] ?? 0) + transaction.value;
      }
    }
    if (categoryTotals.isEmpty) return null;
    return categoryTotals.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  /// Retorna a transação com o maior valor dentro do mês selecionado.
  Transaction? getHighestTransactionForMonth(int monthIndex) {
    List<Transaction> filteredTransactions =
        transactions.where((transaction) => transaction.date.month == monthIndex + 1).toList();

    if (filteredTransactions.isEmpty) return null;

    return filteredTransactions.reduce((a, b) => a.value > b.value ? a : b);
  }

  /// Calcula o total de despesas do mês selecionado.
  double totalExpenses(int monthIndex) {
    return transactions
        .where((transaction) => transaction.date.month == monthIndex + 1)
        .fold(0, (sum, transaction) => sum + transaction.value);
  }

  /// Gera os dados do gráfico de pizza com base nos gastos do mês.
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
            titlePositionPercentageOffset: 2,
            titleStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _getCategoryColor(entry.key),
            ),
          ),
        )
        .toList();
  }

  /// Retorna a cor associada a cada categoria de gastos.
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