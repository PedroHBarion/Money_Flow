import 'package:flutter/material.dart';
import 'src/widgets/CustomMonthNavigation.dart'; // Importe o widget corretamente

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentMonthIndex = 0; // Exemplo de índice de mês selecionado
  List<String> months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  void changeMonth(int direction) {
    setState(() {
      currentMonthIndex = (currentMonthIndex + direction) % 12;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Month Navigation Example"),
      ),
      body: Column(
        children: [
          CustomMonthNavigation(
            currentMonthIndex: currentMonthIndex,
            months: months,
            onMonthChanged: changeMonth,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.access_alarm),
                onPressed: () {
                  // Ação para o ícone 1
                },
              ),
              Text(
                "Exemplo de Texto no Row",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.access_time),
                onPressed: () {
                  // Ação para o ícone 2
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
