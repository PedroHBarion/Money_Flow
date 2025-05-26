import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // Para usar Timer
import 'package:app_money_flow/src/app_money_flow.dart';
import 'package:app_money_flow/src/core/config/locator.dart';
import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:app_money_flow/src/core/services/toast_service.dart';
import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts_controller.dart';
import 'package:app_money_flow/src/pages/home/widgets/transactions/transactions_controller.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  // Ativa o modo imersivo no início
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  // Observador para reaplicar modo imersivo ao voltar do background
  WidgetsBinding.instance.addObserver(_AppLifecycleReactor());

  // Injeção de dependências
  getIt.registerSingleton<ToastService>(ToastService());

  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => getIt<AccountsController>()),
        ChangeNotifierProvider(create: (_) => getIt<TransactionsController>()),
      ],
      child: const MyApp(),
    ),
  );
}

// Classe que reaplica o modo imersivo quando o app volta do background
class _AppLifecycleReactor extends WidgetsBindingObserver {
  Timer? _timer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _applyImmersiveMode();
    }
  }

  void _applyImmersiveMode() {
    _timer?.cancel(); // Cancela qualquer timer anterior
    _timer = Timer(const Duration(seconds: 1), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    });
  }

  @override
  void didChangeMetrics() {
    _applyImmersiveMode();
  }
}
