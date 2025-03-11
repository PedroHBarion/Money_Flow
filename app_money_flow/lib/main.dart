import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'src/widgets/CustomMonthNavigation.dart'; // Importe o widget corretamente

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Expenses")),
      body: Center(
        // Centraliza o conteúdo
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment
                  .center, // Centraliza verticalmente os itens no Column
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
                  //Card - Current balance
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
                  //Card - Expected expenses
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
                  sections:
                      showingSections(), // Chamando a função para gerar as seções
                  centerSpaceRadius:
                      50, // Espaço no centro para dar efeito "Doughnut"
                ),
              ),
            ),
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
        value: 16,
        title: '',
        radius: 20,
      ),
      PieChartSectionData(
        color: const Color.fromRGBO(255, 146, 43, 1),
        value: 20,
        title: '',
        radius: 20,
      ),
    ];
  }
}
