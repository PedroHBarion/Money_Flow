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

  int touchedIndex = -1; // Índice de seção tocada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Expenses")),
      body: Center(
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
