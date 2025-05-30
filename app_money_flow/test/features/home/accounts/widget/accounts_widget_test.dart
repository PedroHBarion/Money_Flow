import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts.dart';
import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_money_flow/src/core/models/bank_account_model.dart';
import 'package:app_money_flow/src/core/services/bank_accounts_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../mock/accounts.mocks.dart';

@GenerateMocks([BankAccountsService])
void main() {
  late MockBankAccountsService mockService;
  late AccountsController controller;
  final getIt = GetIt.instance;

  final fakeAccounts = [
    BankAccountModel(
        id: "1",
        name: 'Conta A',
        type: "CHECKING",
        initialBalance: 500.0,
        color: "#333",
        currentBalance: 1500),
    BankAccountModel(
        id: "2",
        name: 'Conta B',
        type: "INVESTMENT",
        initialBalance: 1000.0,
        color: "#000",
        currentBalance: 1000),
  ];

  setUp(() {
    mockService = MockBankAccountsService();
    controller = AccountsController(service: mockService);

    if (getIt.isRegistered<AccountsController>()) {
      getIt.unregister<AccountsController>();
    }
    getIt.registerSingleton<AccountsController>(controller);
  });

  tearDown(() {
    getIt.reset();
  });

  Future<void> pumpAccountsWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AccountsController>(
          create: (_) => controller,
          child: AccountBalanceCard(),
        ),
      ),
    );
  }

  group('Accounts Widget', () {
    testWidgets('deve exibir o loading enquanto carrega as contas',
        (tester) async {
      when(mockService.getAll()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return fakeAccounts;
      });

      await pumpAccountsWidget(tester);
      // Dispara o primeiro frame
      await tester.pump();

      // Verifica o loading
      expect(find.byType(CircularProgressIndicator), findsNWidgets(2));

      // Aguarda todos os timers e animações terminarem
      await tester.pumpAndSettle();
    });

    testWidgets('deve esconder o saldo ao alternar isHidden', (tester) async {
      when(mockService.getAll()).thenAnswer((_) async => fakeAccounts);

      await pumpAccountsWidget(tester);
      await tester.pumpAndSettle();

      final textFinder = find.byKey(const Key('total-balance'));
      Text textWidget = tester.widget<Text>(textFinder);

      expect(textWidget.style?.color, Colors.white);

      controller.toggleHidden();
      await tester.pumpAndSettle();

      textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.color, Colors.transparent);
    });

    testWidgets('deve exibir uma lista de contas após carregamento',
        (tester) async {
      when(mockService.getAll()).thenAnswer((_) async => fakeAccounts);

      await pumpAccountsWidget(tester);
      await controller.loadAccounts();
      await tester.pumpAndSettle(); // espera animações e futuros terminarem

      expect(find.text('Conta A'), findsOneWidget);
      expect(find.text('Conta B'), findsOneWidget);
    });

    // Tem erro
    testWidgets(
      'deve exibir mensagem de erro caso ocorra falha no carregamento',
      (tester) async {
        when(mockService.getAll()).thenThrow(Exception('Erro ao carregar'));

        await pumpAccountsWidget(tester);

        // Executa a função que realmente tenta carregar e falha
        await controller.loadAccounts();

        // Aguarda a renderização final após a mudança de estado
        await tester.pumpAndSettle();

        // Aqui a mensagem de erro deveria estar visível
        expect(
          find.textContaining('Erro ao buscar contas bancárias'),
          findsOneWidget,
        );
      },
    );

    testWidgets('deve reagir à atualização do estado', (tester) async {
      when(mockService.getAll()).thenAnswer((_) async => []);

      await pumpAccountsWidget(tester);
      await tester.pumpAndSettle();

      // Atualiza o estado
      when(mockService.getAll()).thenAnswer((_) async => fakeAccounts);
      await controller.loadAccounts();
      await tester.pumpAndSettle();

      expect(find.text('Conta A'), findsOneWidget);
    });

// tem erro
    testWidgets('deve renderizar nome, saldo e tipo corretamente',
        (tester) async {
      when(mockService.getAll()).thenAnswer((_) async => fakeAccounts);

      await pumpAccountsWidget(tester);
      await controller.loadAccounts();
      await tester.pumpAndSettle();

      expect(find.text('Conta A'), findsOneWidget);
      expect(find.text('R\$ 1.500'), findsOneWidget);
      expect(find.text('Conta B'), findsOneWidget);
      expect(find.text('R\$ 1.000'), findsOneWidget);
    });

    // Unico que está funcionado
    testWidgets('deve exibir componente correto para lista vazia',
        (tester) async {
      when(mockService.getAll()).thenAnswer((_) async => []);

      await pumpAccountsWidget(tester);
      await tester.pumpAndSettle();

      expect(find.textContaining('Cadastre uma\nnova conta'), findsOneWidget);
    });
  });
}
