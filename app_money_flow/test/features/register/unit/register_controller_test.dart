// ignore_for_file: unused_local_variable
import 'package:app_money_flow/src/core/models/register_model.dart';
import 'package:app_money_flow/src/core/services/toast_service.dart';
import 'package:app_money_flow/src/pages/register/register_page_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';

import '../../login/mocks/login.mocks.dart';

// Simula o contexto necessário
class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late RegisterController controller;
  late MockAuthService mockAuthService;
  late MockToastService mockToastService;

  setUp(() {
    mockAuthService = MockAuthService();
    controller = RegisterController(mockAuthService);
    mockToastService = MockToastService();
    GetIt.I.registerSingleton<ToastService>(MockToastService());
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('Não chama handleRegister se formulário for inválido',
      (tester) async {
    final mockAuthService = MockAuthService();
    final controller = RegisterController(mockAuthService);

    // UI simulada com campos com validator
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.nameController,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Campo obrigatório'
                      : null,
                ),
                TextFormField(
                  controller: controller.emailController,
                  validator: (value) => (value == null || !value.contains('@'))
                      ? 'Email inválido'
                      : null,
                ),
                TextFormField(
                  controller: controller.passwordController,
                  validator: (value) => (value == null || value.length < 6)
                      ? 'Senha fraca'
                      : null,
                ),
                ElevatedButton(
                  onPressed: () => controller
                      .validateAndRegister(tester.element(find.byType(Form))),
                  child: const Text('Registrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pump(); // Deixa o widget montar

    // Não preenche os campos => inválido
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verifica se NADA foi chamado
    verifyNever(mockAuthService.signup(any));
  });

  group('RegisterController - fluxo de sucesso', () {
    late RegisterController controller;
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
      controller = RegisterController(mockAuthService);
    });

    test('deve chamar signup se os dados forem válidos', () async {
      // Preenche os campos corretamente
      controller.nameController.text = 'João';
      controller.emailController.text = 'joao@email.com';
      controller.passwordController.text = '123456';
      controller.confirmPasswordController.text = '123456';

      var register = RegisterModel(
          name: controller.nameController.text,
          email: controller.emailController.text,
          password: controller.passwordController.text);

      // Simula a chamada real
      when(mockAuthService.signup(register)).thenAnswer((_) async => 'token');

      await controller.handleRegister(FakeBuildContext(), register);

      verify(mockAuthService.signup(register)).called(1);
    });
  });
}
