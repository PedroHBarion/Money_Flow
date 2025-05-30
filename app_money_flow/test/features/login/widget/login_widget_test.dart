import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:app_money_flow/src/pages/login/login_page.dart';
import 'package:app_money_flow/src/pages/login/login_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../expenses/mocks/expenses.mocks.dart';

void main() {
  late MockAuthService mockAuthService;

  setUp(() async {
    await GetIt.I.reset();
    mockAuthService = MockAuthService();
    GetIt.I.registerSingleton<AuthService>(mockAuthService);
  });

  testWidgets('Deve renderizar os campos de e-mail e senha', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginController(mockAuthService),
          child: const LoginScreen(),
        ),
      ),
    );

    expect(find.text('Entre em sua conta'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'E-mail'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Senha'), findsOneWidget);
  });

  testWidgets(
      'Deve navegar para a tela de cadastro ao clicar em "Crie uma aqui"',
      (tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        routes: {
          '/register': (_) => const Scaffold(body: Text('Cadastro')),
        },
        home: ChangeNotifierProvider(
          create: (_) => LoginController(mockAuthService),
          child: const LoginScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Crie uma aqui'));
    await tester.pumpAndSettle();

    expect(find.text('Cadastro'), findsOneWidget);
  });

  testWidgets('Deve mostrar erro se campos forem inválidos ao tentar logar',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginController(mockAuthService),
          child: const LoginScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(find.text('O e-mail é obrigatório'), findsOneWidget);
    expect(find.text('A senha é obrigatória'), findsOneWidget);
  });
}
