import 'package:app_money_flow/src/core/models/login_model.dart';
import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:app_money_flow/src/core/services/toast_service.dart';
import 'package:app_money_flow/src/pages/login/login_page_controller.dart';
import 'package:app_money_flow/src/widgets/toast/animated_toast.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../mocks/login.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockAuthProvider mockAuthProvider;
  late MockToastService mockToastService;
  late LoginController controller;

  setUp(() {
    mockAuthService = MockAuthService();
    mockAuthProvider = MockAuthProvider();
    mockToastService = MockToastService();

    GetIt.I.registerSingleton<AuthService>(mockAuthService);
    GetIt.I.registerSingleton<AuthProvider>(mockAuthProvider);
    GetIt.I.registerSingleton<ToastService>(mockToastService);

    controller = LoginController(mockAuthService);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('Deve logar com sucesso e redirecionar para splash',
      (tester) async {
    final token = 'fake_token';

    when(mockAuthService.signin(any)).thenAnswer((_) async => token);
    when(mockAuthProvider.signin(token)).thenAnswer((_) async {});

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => controller),
          ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                controller.emailController.text = 'user@email.com';
                controller.passwordController.text = '12345678';
                controller.handleLogin(
                  context,
                  LoginModel(
                    email: controller.emailController.text,
                    password: controller.passwordController.text,
                  ),
                );
                return const Placeholder();
              },
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    verify(mockAuthService.signin(any)).called(1);
    verify(mockAuthProvider.signin(token)).called(1);
  });

  testWidgets('Deve mostrar toast de erro ao falhar no login', (tester) async {
    when(mockAuthService.signin(any)).thenThrow(Exception('Erro'));
    when(mockToastService.show(
      message: 'Login inválido. Verifique suas credenciais!',
      type: ToastType.error,
    )).thenReturn(null); // Mockar método show para evitar ação real

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => controller),
          ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
        ],
        child: MaterialApp(
          routes: {
            '/splash': (_) => const Scaffold(body: Text('Splash')),
          },
          home: Scaffold(
            body: Builder(
              builder: (context) {
                controller.emailController.text = 'user@email.com';
                controller.passwordController.text = '12345678';
                controller.handleLogin(
                  context,
                  LoginModel(
                    email: controller.emailController.text,
                    password: controller.passwordController.text,
                  ),
                );
                return const Placeholder();
              },
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    verify(mockAuthService.signin(any)).called(1);
    // Verifica se o toast de erro foi chamado
    verify(mockToastService.show(
      message: 'Login inválido. Verifique suas credenciais!',
      type: ToastType.error,
    )).called(1);
  });
}
