import 'package:app_money_flow/src/pages/expenses_page/expenses_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyExpensesPage());
  }
}
