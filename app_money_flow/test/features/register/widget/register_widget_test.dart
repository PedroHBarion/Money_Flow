import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:app_money_flow/src/pages/register/register_page.dart';
import 'package:app_money_flow/src/pages/register/register_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../mocks/register.mocks.dart';

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
          create: (_) => RegisterController(mockAuthService),
          child: const RegisterPage(),
        ),
      ),
    );

    expect(find.text('Fazer Login'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Nome'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Senha'), findsOneWidget);
    expect(
        find.widgetWithText(TextFormField, 'Confirmar Senha'), findsOneWidget);
  });

  testWidgets('Deve navegar para a tela de login ao clicar em "Fazer login"',
      (tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        routes: {
          '/login': (_) => const Scaffold(body: Text('Entrar')),
        },
        home: ChangeNotifierProvider(
          create: (_) => RegisterController(mockAuthService),
          child: const RegisterPage(),
        ),
      ),
    );

    await tester.tap(find.text('Fazer Login'));
    await tester.pumpAndSettle();

    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('Deve mostrar erro se campos forem inválidos ao tentar logar',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => RegisterController(mockAuthService),
          child: const RegisterPage(),
        ),
      ),
    );

    await tester.tap(find.text('Criar Conta'));
    await tester.pump();

    expect(find.text('O nome é obrigatório'), findsOneWidget);
    expect(find.text('O e-mail é obrigatório'), findsOneWidget);
    expect(find.text('A senha é obrigatória'), findsOneWidget);
    expect(find.text('A confirmação é obrigatória'), findsOneWidget);
  });
}
