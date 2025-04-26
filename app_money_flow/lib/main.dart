import 'package:app_money_flow/src/app_money_flow.dart';
import 'package:app_money_flow/src/core/config/locator.dart';
import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:app_money_flow/src/core/services/toast_service.dart';
import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts_controller.dart';
import 'package:app_money_flow/src/pages/home/widgets/transactions/transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  getIt.registerSingleton<ToastService>(ToastService());
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => getIt<AccountsController>()),
        ChangeNotifierProvider(create: (_) => getIt<TransactionsController>()),
      ],
      child: MyApp(),
    ),
  );
}
