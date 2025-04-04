import 'package:app_money_flow/src/app_money_flow.dart';
import 'package:app_money_flow/src/core/config/locator.dart';
import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}