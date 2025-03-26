import 'package:app_money_flow/src/pages/expenses_page/widgets/balance_card.dart';
import 'package:app_money_flow/src/widgets/custom_month_navigation.dart';
import 'package:app_money_flow/src/widgets/savings_suggestion_card.dart';
import 'package:app_money_flow/src/widgets/custom_app_bar.dart';
import 'package:app_money_flow/src/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyExpensesPage extends StatefulWidget {
  const MyExpensesPage({super.key});

  @override
  _MyExpensesPage createState() => _MyExpensesPage();
}

class _MyExpensesPage extends State<MyExpensesPage> {
  int currentMonthIndex = 0; // Índice do mês selecionado
  int touchedIndex = -1; // Índice de seção tocada
  List<PieChartSectionData> chartData = []; // Dados do gráfico

  @override
  void initState() {
    super.initState();
    _fetchDataForMonth(
      currentMonthIndex,
    ); // Buscar dados iniciais para o mês atual
  }

  // Função para buscar os dados do gráfico para um mês específico
  void _fetchDataForMonth(int monthIndex) {
    // >>>> Aqui você deve apagar essa parte quando conectar com o backend <<<<
    // Simulação de dados diferentes para cada mês
    setState(() {
      chartData = _generateDataForMonth(monthIndex);
    });
    // >>>> Apagar até aqui <<<<
  }

  // Função que simula a geração de dados para um mês específico
  // >>>> Essa função será removida e substituída por uma chamada ao backend <<<<
  List<PieChartSectionData> _generateDataForMonth(int monthIndex) {
    // Exemplo simples: altere os valores conforme o mês muda

    // prettier-ignore-start
    if (monthIndex == 0) {
      return [
        PieChartSectionData(
          color: Colors.red,
          value: 25.5,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.65,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        PieChartSectionData(
          color: Colors.green,
          value: 29.5,
          radius: 20,
          showTitle: true,
          title: 'Educação',
          titlePositionPercentageOffset: 2.65,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        PieChartSectionData(
          color: Colors.purple,
          value: 10,
          radius: 20,
          showTitle: true,
          title: 'Gasolina',
          titlePositionPercentageOffset: 2.65,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        PieChartSectionData(
          color: Colors.orange,
          value: 20,
          radius: 20,
          showTitle: true,
          title: 'Compras Online',
          titlePositionPercentageOffset: 2.65,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        PieChartSectionData(
          color: Colors.blue,
          value: 15,
          radius: 20,
          showTitle: true,
          title: 'Varejo',
          titlePositionPercentageOffset: 2.65,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: Colors.yellow,
          value: 28,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.65,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
        PieChartSectionData(
          color: Colors.green,
          value: 32,
          radius: 20,
          showTitle: true,
          title: 'Educação',
          titlePositionPercentageOffset: 2.65,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        PieChartSectionData(
          color: Colors.blue,
          value: 12,
          radius: 20,
          showTitle: true,
          title: 'Gasolina',
          titlePositionPercentageOffset: 2.65,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        PieChartSectionData(
          color: Colors.orange,
          value: 18,
          radius: 20,
          showTitle: true,
          title: 'Compras Online',
          titlePositionPercentageOffset: 2.65,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        PieChartSectionData(
          color: Colors.purple,
          value: 10,
          radius: 20,
          showTitle: true,
          title: 'Varejo',
          titlePositionPercentageOffset: 2.65,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ];
    }
  }
  // >>>> Apagar essa função  <<<<

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
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (event.isInterestedForInteractions &&
                              pieTouchResponse != null &&
                              pieTouchResponse.touchedSection != null) {
                            touchedIndex =
                                pieTouchResponse
                                    .touchedSection!
                                    .touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),

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
