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
        PieChartSectionData(
          color: Colors.red,
          value: 25.5,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.5,
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
          title: 'Alimentação',
          titlePositionPercentageOffset: 2.5,
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
          titlePositionPercentageOffset: 2.5,
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
          titlePositionPercentageOffset: 2.5,
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
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ];
    } else if (monthIndex == 2) {
      return [
        PieChartSectionData(
          color: Colors.yellow,
          value: 28,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.5,
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
          title: 'Alimentação',
          titlePositionPercentageOffset: 2.5,
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
          titlePositionPercentageOffset: 2.5,
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
          titlePositionPercentageOffset: 2.5,
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
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ];
    } else if (monthIndex == 3) {
      return [
        PieChartSectionData(
          color: Colors.pink,
          value: 20,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
        PieChartSectionData(
          color: Colors.teal,
          value: 35,
          radius: 20,
          showTitle: true,
          title: 'Alimentação',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        PieChartSectionData(
          color: Colors.brown,
          value: 25,
          radius: 20,
          showTitle: true,
          title: 'Gasolina',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        PieChartSectionData(
          color: Colors.indigo,
          value: 10,
          radius: 20,
          showTitle: true,
          title: 'Compras Online',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        PieChartSectionData(
          color: Colors.yellow,
          value: 10,
          radius: 20,
          showTitle: true,
          title: 'Varejo',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
      ];
    } else if (monthIndex == 4) {
      return [
        PieChartSectionData(
          color: Colors.purple,
          value: 22,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        PieChartSectionData(
          color: Colors.red,
          value: 18,
          radius: 20,
          showTitle: true,
          title: 'Alimentação',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        PieChartSectionData(
          color: Colors.orange,
          value: 30,
          radius: 20,
          showTitle: true,
          title: 'Gasolina',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        PieChartSectionData(
          color: Colors.green,
          value: 15,
          radius: 20,
          showTitle: true,
          title: 'Compras Online',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        PieChartSectionData(
          color: Colors.blue,
          value: 15,
          radius: 20,
          showTitle: true,
          title: 'Varejo',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ];
    } else if (monthIndex == 5) {
      return [
        PieChartSectionData(
          color: Colors.red,
          value: 30,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        PieChartSectionData(
          color: Colors.yellow,
          value: 22,
          radius: 20,
          showTitle: true,
          title: 'Alimentação',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
        PieChartSectionData(
          color: Colors.blue,
          value: 20,
          radius: 20,
          showTitle: true,
          title: 'Gasolina',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        PieChartSectionData(
          color: Colors.green,
          value: 18,
          radius: 20,
          showTitle: true,
          title: 'Compras Online',
          titlePositionPercentageOffset: 2.5,
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
          title: 'Varejo',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ];
    }
    if (monthIndex == 6) {
      return [
        PieChartSectionData(
          color: Colors.cyan,
          value: 23,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.cyan,
          ),
        ),
        PieChartSectionData(
          color: Colors.pink,
          value: 27,
          radius: 20,
          showTitle: true,
          title: 'Alimentação',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
        PieChartSectionData(
          color: Colors.blueGrey,
          value: 12,
          radius: 20,
          showTitle: true,
          title: 'Gasolina',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        PieChartSectionData(
          color: Colors.orange,
          value: 18,
          radius: 20,
          showTitle: true,
          title: 'Compras Online',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        PieChartSectionData(
          color: Colors.green,
          value: 20,
          radius: 20,
          showTitle: true,
          title: 'Varejo',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ];
    } else if (monthIndex == 7) {
      return [
        PieChartSectionData(
          color: Colors.red,
          value: 30,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        PieChartSectionData(
          color: Colors.yellow,
          value: 25,
          radius: 20,
          showTitle: true,
          title: 'Alimentação',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
        PieChartSectionData(
          color: Colors.green,
          value: 20,
          radius: 20,
          showTitle: true,
          title: 'Gasolina',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        PieChartSectionData(
          color: Colors.blue,
          value: 15,
          radius: 20,
          showTitle: true,
          title: 'Compras Online',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        PieChartSectionData(
          color: Colors.purple,
          value: 10,
          radius: 20,
          showTitle: true,
          title: 'Varejo',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ];
    } else if (monthIndex == 8) {
      return [
        PieChartSectionData(
          color: Colors.purple,
          value: 35,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        PieChartSectionData(
          color: Colors.cyan,
          value: 25,
          radius: 20,
          showTitle: true,
          title: 'Alimentação',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.cyan,
          ),
        ),
        PieChartSectionData(
          color: Colors.orange,
          value: 15,
          radius: 20,
          showTitle: true,
          title: 'Gasolina',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        PieChartSectionData(
          color: Colors.green,
          value: 10,
          radius: 20,
          showTitle: true,
          title: 'Compras Online',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        PieChartSectionData(
          color: Colors.red,
          value: 15,
          radius: 20,
          showTitle: true,
          title: 'Varejo',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ];
    } else if (monthIndex == 9) {
      return [
        PieChartSectionData(
          color: Colors.orange,
          value: 28,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        PieChartSectionData(
          color: Colors.blue,
          value: 22,
          radius: 20,
          showTitle: true,
          title: 'Alimentação',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        PieChartSectionData(
          color: Colors.green,
          value: 20,
          radius: 20,
          showTitle: true,
          title: 'Gasolina',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        PieChartSectionData(
          color: Colors.yellow,
          value: 15,
          radius: 20,
          showTitle: true,
          title: 'Compras Online',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
        PieChartSectionData(
          color: Colors.red,
          value: 15,
          radius: 20,
          showTitle: true,
          title: 'Varejo',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ];
    } else if (monthIndex == 10) {
      return [
        PieChartSectionData(
          color: Colors.green,
          value: 30,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        PieChartSectionData(
          color: Colors.red,
          value: 20,
          radius: 20,
          showTitle: true,
          title: 'Alimentação',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        PieChartSectionData(
          color: Colors.purple,
          value: 25,
          radius: 20,
          showTitle: true,
          title: 'Gasolina',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        PieChartSectionData(
          color: Colors.yellow,
          value: 10,
          radius: 20,
          showTitle: true,
          title: 'Compras Online',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
        PieChartSectionData(
          color: Colors.blue,
          value: 15,
          radius: 20,
          showTitle: true,
          title: 'Varejo',
          titlePositionPercentageOffset: 2.5,
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
          color: Colors.pink,
          value: 20,
          radius: 20,
          showTitle: true,
          title: 'Roupas',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
        PieChartSectionData(
          color: Colors.teal,
          value: 35,
          radius: 20,
          showTitle: true,
          title: 'Alimentação',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        PieChartSectionData(
          color: Colors.brown,
          value: 25,
          radius: 20,
          showTitle: true,
          title: 'Gasolina',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        PieChartSectionData(
          color: Colors.indigo,
          value: 10,
          radius: 20,
          showTitle: true,
          title: 'Compras Online',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        PieChartSectionData(
          color: Colors.yellow,
          value: 10,
          radius: 20,
          showTitle: true,
          title: 'Varejo',
          titlePositionPercentageOffset: 2.5,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
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
                  Card(
                    // Card Saldo Atual Total
                    margin: EdgeInsets.all(8),
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
                    margin: EdgeInsets.all(8),
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
