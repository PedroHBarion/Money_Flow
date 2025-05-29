// import 'package:app_money_flow/src/core/models/register_model.dart';
// import 'package:app_money_flow/src/core/provider/auth_provider.dart';
// import 'package:app_money_flow/src/core/services/auth_service.dart';
// import 'package:app_money_flow/src/pages/register/register_page.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
// import '../mocks/register.mocks.dart';

// void main() {
//   setUp(() {
//     mockAuthService = MockAuthService();
//     mockAuthProvider = MockAuthProvider();

//     GetIt.I.registerSingleton<AuthService>(mockAuthService);
//     GetIt.I
//         .registerSingleton<AuthProvider>(mockAuthProvider); // <-- Adicione isso
//   });

//   tearDown(() {
//     GetIt.I.reset();
//   });

//   Future<void> pumpRegisterPage(WidgetTester tester) async {
//     var mockAuthProvider;
//     await tester.pumpWidget(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
//         ],
//         child: const MaterialApp(home: RegisterPage()),
//       ),
//     );
//     await tester.pump();
//   }

//   testWidgets('Deve validar campos obrigatórios', (tester) async {
//     await pumpRegisterPage(tester);

//     await tester.tap(find.text('Criar Conta'));
//     await tester.pump();

//     expect(find.text('O nome é obrigatório'), findsOneWidget);
//     expect(find.text('O e-mail é obrigatório'), findsOneWidget);
//     expect(find.text('A senha é obrigatória'), findsOneWidget);
//     expect(find.text('A confirmação é obrigatória'), findsOneWidget);
//   });

//   testWidgets('Deve registrar com sucesso', (tester) async {
//     when(mockAuthService.signup(any)).thenAnswer((_) async => 'fake_token');
//     when(mockAuthProvider.signin(any)).thenAnswer((_) async => null);

//     await pumpRegisterPage(tester);

//     await tester.enterText(find.bySemanticsLabel('Nome'), 'João Silva');
//     await tester.enterText(find.bySemanticsLabel('Email'), 'joao@email.com');
//     await tester.enterText(find.bySemanticsLabel('Senha'), '12345678');
//     await tester.enterText(
//         find.bySemanticsLabel('Confirmar Senha'), '12345678');

//     await tester.tap(find.text('Criar Conta'));
//     await tester.pumpAndSettle();

//     final captured = verify(mockAuthService.signup(captureAny)).captured.single
//         as RegisterModel;

//     expect(captured.name, 'João Silva');
//     expect(captured.email, 'joao@email.com');
//     expect(captured.password, '12345678');

//     verify(mockAuthProvider.signin('fake_token')).called(1);
//   });

//   testWidgets('Deve exibir erro quando signup falha', (tester) async {
//     when(mockAuthService.signup(any)).thenThrow(Exception('Erro'));

//     await pumpRegisterPage(tester);

//     await tester.enterText(find.bySemanticsLabel('Nome'), 'Maria');
//     await tester.enterText(find.bySemanticsLabel('Email'), 'maria@email.com');
//     await tester.enterText(find.bySemanticsLabel('Senha'), '12345678');
//     await tester.enterText(
//         find.bySemanticsLabel('Confirmar Senha'), '12345678');

//     await tester.tap(find.text('Criar Conta'));
//     await tester.pumpAndSettle();

//     expect(
//         find.text('Erro ao criar conta. Verifique os dados!'), findsOneWidget);
//   });
// }
