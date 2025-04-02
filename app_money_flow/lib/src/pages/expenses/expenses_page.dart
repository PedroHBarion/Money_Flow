import 'package:app_money_flow/src/core/models/transaction.dart';
import 'package:app_money_flow/src/widgets/balance_card.dart';
import 'package:app_money_flow/src/widgets/custom_month_navigation.dart';
import 'package:app_money_flow/src/widgets/savings_suggestion_card.dart';
import 'package:app_money_flow/src/widgets/custom_app_bar.dart';
import 'package:app_money_flow/src/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app_money_flow/src/core/services/expense_service.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  int currentMonthIndex = 0; // Índice do mês selecionado
  List<PieChartSectionData> chartData = []; // Dados do gráfico
  List<Transaction> transactions = []; // Lista de transações

  @override
  void initState() {
    super.initState();
    _fetchDataForMonth(
      currentMonthIndex,
    ); // Buscar dados iniciais para o mês atual
  }

  // Função para buscar as transações e gerar os dados para o gráfico
  void _fetchDataForMonth(int monthIndex) async {
    ExpenseService expenseService = ExpenseService();
    try {
      // Buscar transações usando o ExpenseService
      List<Transaction> fetchedTransactions =
          await expenseService.fetchTransactions();

      setState(() {
        transactions = fetchedTransactions;
        chartData = _generateChartData(monthIndex);
      });
    } catch (e) {
      // Tratar erro caso o carregamento falhe
      print("Erro ao carregar transações: $e");
    }
  }

  // Função que gera os dados do gráfico de acordo com o mês e transações
  List<PieChartSectionData> _generateChartData(int monthIndex) {
    // Agrupar as transações por categoria e calcular os totais
    Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      if (transaction.date.month == monthIndex + 1) {
        // Verifica se a transação é do mês selecionado
        if (categoryTotals.containsKey(transaction.category)) {
          categoryTotals[transaction.category] =
              categoryTotals[transaction.category]! + transaction.value;
        } else {
          categoryTotals[transaction.category] = transaction.value;
        }
      }
    }

    // Gerar os dados para o gráfico de pizza
    List<PieChartSectionData> sections = [];
    categoryTotals.forEach((category, total) {
      Color sectionColor = _getCategoryColor(category);
      sections.add(
        PieChartSectionData(
          color: sectionColor,
          value: total,
          radius: 30,
          showTitle: true,
          title: '$category\nR\$ ${total.toStringAsFixed(2)}',
          titlePositionPercentageOffset: 1.5,
          titleStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: sectionColor,
          ),
        ),
      );
    });
    return sections;
  }

  // Função para determinar a cor do gráfico com base na categoria
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      backgroundColor: Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              CustomMonthNavigation(
                currentMonthIndex: currentMonthIndex,
                onMonthChanged: (newIndex) {
                  setState(() {
                    currentMonthIndex = newIndex;
                    _fetchDataForMonth(
                      newIndex,
                    ); // Atualizar dados ao mudar o mês
                  });
                },
              ),
              SizedBox(height: 20), // Espaçamento entre os elementos

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BalanceCard(
                    title: "Saldo atual total",
                    subTitle: "R\$: 59,45",
                    subTitlecolor: Color(0xFFFFFFFF),
                    titleColor: Color(0xFFFFFFFF),
                    background: Color(0xFF087F5B),
                  ),
                  BalanceCard(
                    title: "Gastos Previstos",
                    subTitle: "R\$ 2936,00",
                    subTitlecolor: Color(0xFF087F5B),
                    titleColor: Color.fromARGB(255, 0, 0, 0),
                    background: Color(0xFFFFFFFF),
                  ),
                ],
              ),
              SizedBox(height: 20), // Espaçamento entre os elementos
              // Gráfico Doughnut (Gráfico de Rosca)
              SizedBox(
                height: 200, // Definir o tamanho do gráfico
                child: PieChart(
                  PieChartData(
                    sections: chartData,
                    centerSpaceRadius:
                        50, // Espaço no centro para dar efeito "Doughnut"
                  ),
                ),
              ),

              // Exemplo de transações (pode ser melhorado com dados reais)
              TransactionCard(
                iconPath:
                    'assets/icons/shopping_cart.svg', //Icons.shopping_cart
                color: 0xFFFFFFFF,
                title: "Principal Gasto",
                date: "Roupas",
                amount: "-R\$ 693,00",
              ),
              SavingsSuggestionCard(),
            ],
          ),
        ),
      ),
    );
  }
}
