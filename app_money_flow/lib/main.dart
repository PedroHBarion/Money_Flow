
import 'package:app_money_flow/src/pages/home.dart';
import 'package:app_money_flow/src/pages/create_user_profile.dart';
import 'package:app_money_flow/src/pages/my_expenses_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:  Home(),
    );
  }
}


