import 'package:app_money_flow/src/widgets/custom_month_navigation.dart';
import 'package:app_money_flow/src/widgets/custom_transaction_card.dart';
import 'package:app_money_flow/src/widgets/savings_suggestion_card.dart';
import 'package:app_money_flow/src/widgets/custom_app_bar.dart';
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
    PieChartSectionData(color: Colors.red, value: 25, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.green, value: 30, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.purple, value: 10, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.orange, value: 20, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.blue, value: 15, radius: 20, showTitle: false),
  ];
} else if (monthIndex == 2) {
  return [
    PieChartSectionData(color: Colors.yellow, value: 28, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.green, value: 32, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.blue, value: 12, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.orange, value: 18, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.purple, value: 10, radius: 20, showTitle: false),
  ];
} else if (monthIndex == 3) {
  return [
    PieChartSectionData(color: Colors.pink, value: 20, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.teal, value: 35, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.brown, value: 25, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.indigo, value: 10, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.yellow, value: 10, radius: 20, showTitle: false),
  ];
} else if (monthIndex == 4) {
  return [
    PieChartSectionData(color: Colors.purple, value: 22, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.red, value: 18, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.orange, value: 30, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.green, value: 15, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.blue, value: 15, radius: 20, showTitle: false),
  ];
} else if (monthIndex == 5) {
  return [
    PieChartSectionData(color: Colors.red, value: 30, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.yellow, value: 22, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.blue, value: 20, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.green, value: 18, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.purple, value: 10, radius: 20, showTitle: false),
  ];
} else if (monthIndex == 6) {
  return [
    PieChartSectionData(color: Colors.green, value: 30, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.blue, value: 20, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.pink, value: 15, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.yellow, value: 25, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.red, value: 10, radius: 20, showTitle: false),
  ];
} else if (monthIndex == 7) {
  return [
    PieChartSectionData(color: Colors.brown, value: 25, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.green, value: 28, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.yellow, value: 15, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.blue, value: 20, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.purple, value: 12, radius: 20, showTitle: false),
  ];
} else if (monthIndex == 8) {
  return [
    PieChartSectionData(color: Colors.orange, value: 35, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.blue, value: 25, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.purple, value: 15, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.green, value: 15, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.red, value: 10, radius: 20, showTitle: false),
  ];
} else if (monthIndex == 9) {
  return [
    PieChartSectionData(color: Colors.teal, value: 40, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.orange, value: 20, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.blue, value: 18, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.green, value: 12, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.red, value: 10, radius: 20, showTitle: false),
  ];
} else if (monthIndex == 10) {
  return [
    PieChartSectionData(color: Colors.purple, value: 30, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.red, value: 22, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.green, value: 20, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.blue, value: 18, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.yellow, value: 10, radius: 20, showTitle: false),
  ];
} else {
  return [
    PieChartSectionData(color: Colors.red, value: 28, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.green, value: 25, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.purple, value: 20, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.blue, value: 15, radius: 20, showTitle: false),
    PieChartSectionData(color: Colors.orange, value: 12, radius: 20, showTitle: false),
  ];
}
// prettier-ignore-end
  }
  // >>>> Apagar essa função quando o backend estiver pronto <<<<

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      backgroundColor: Color(0xFFF8FFFD),
      body: Center(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  // Card Saldo Atual Total
                  margin: EdgeInsets.all(16),
                  elevation: 4,
                  color: const Color(0xFF087F5B),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Saldo Atual Total",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "R\$ 59,45",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  // Gastos Previstos
                  color: Color(0xFFFFFFFF),
                  margin: EdgeInsets.all(16),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gastos Previstos",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "R\$ 2936,00",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
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
            if (touchedIndex != -1)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  getTitleForSection(touchedIndex),
                  style: TextStyle(
                    color: Color(0xFF087F5B), // Cor #087F5B
                    fontFamily: 'DM Sans', // Família "DM Sans"
                    fontSize: 16, // Tamanho da fonte 16px
                    fontWeight: FontWeight.w600, // Peso da fonte 600
                    height: 1.5, // Line-height 150% (1.5 em Flutter)
                    letterSpacing: -0.5, // Espaçamento entre letras -0.5px
                    fontStyle: FontStyle.normal, // Estilo normal
                  ),
                  textAlign: TextAlign.center, // Alinhamento centralizado
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(" ", style: TextStyle(fontSize: 17)),
              ),

            // Adicionando o CustomTransactionCard abaixo do gráfico
            CustomTransactionCard(
              icon: Icons.shopping_cart, // Exemplo de ícone
              title: "Principal Gasto", // Título
              value: "Roupas", // Substituímos o valor por "Roupas"
              extraText: "-R\$ 693,00", // Texto único com o valor negativo
            ),
            SavingsSuggestionCard(),
          ],
        ),
      ),
    );
  }

  // Função para retornar o título de acordo com o índice
  String getTitleForSection(int index) {
    switch (index) {
      case 0:
        return 'Roupas';
      case 1:
        return 'Alimentação';
      case 2:
        return 'Gasolina';
      case 3:
        return 'Compras Online';
      case 4:
        return 'Varejo';
      default:
        return '';
    }
  }
}
