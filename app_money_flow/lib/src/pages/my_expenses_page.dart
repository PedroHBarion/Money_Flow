import 'package:app_money_flow/src/widgets/CustomMonthNavigation.dart';
import 'package:app_money_flow/src/widgets/CustomTransactionCard.dart';
import 'package:app_money_flow/src/widgets/SavingsSuggestionCard.dart';
import 'package:app_money_flow/src/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyExpensesPage extends StatefulWidget {
  const MyExpensesPage({super.key});

  @override
  _MyExpensesPage createState() => _MyExpensesPage();
}

class _MyExpensesPage extends State<MyExpensesPage> {
  int currentMonthIndex = 0; // Exemplo de índice de mês selecionado
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  void changeMonth(int direction) {
    setState(() {
      currentMonthIndex = (currentMonthIndex + direction) % 12;
    });
  }

  int touchedIndex = -1; // Índice de seção tocada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      backgroundColor: Color(0xFFF8F9FA),
      body: Center(
        child: Column(
          children: [
            CustomMonthNavigation(
              currentMonthIndex: currentMonthIndex,
              months: months,
              onMonthChanged: changeMonth,
            ),
            SizedBox(height: 20), // Espaçamento entre os elementos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
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
                  sections: showingSections(),
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

  // Função para gerar os dados das seções do gráfico
  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: const Color.fromRGBO(8, 127, 91, 1),
        value: 30,
        radius: 20,
        title: '',
      ),
      PieChartSectionData(
        color: const Color.fromRGBO(255, 236, 153, 1),
        value: 16,
        radius: 20,
        title: '',
      ),
      PieChartSectionData(
        color: const Color.fromRGBO(51, 154, 240, 1),
        value: 16,
        radius: 20,
        title: '',
      ),
      PieChartSectionData(
        color: const Color.fromRGBO(140, 233, 154, 1),
        value: 30,
        radius: 20,
        title: '',
      ),
      PieChartSectionData(
        color: const Color.fromRGBO(255, 146, 43, 1),
        value: 20,
        radius: 20,
        title: '',
      ),
    ];
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
