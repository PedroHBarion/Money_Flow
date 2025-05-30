import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_model.dart';
import 'package:app_money_flow/src/pages/home/widgets/transactions/transactions.dart';
import 'package:app_money_flow/src/pages/home/widgets/transactions/transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../mock/transactions.mocks.dart';

void main() {
  group('Transaction Widget Test', () {
    late MockTransactionService mockService;
    late TransactionsController controller;

    setUp(() {
      mockService = MockTransactionService();
      controller = TransactionsController(service: mockService);
    });

    testWidgets('Deve exibir lista de transações após carregar',
        (WidgetTester tester) async {
      // Arrange
      when(mockService.getAll(any)).thenAnswer((_) async => [
            TransactionModel(
              id: '1',
              name: 'Salário',
              value: 5000,
              date: '2025-05-21',
              type: TransactionType.income,
            ),
          ]);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: controller,
            child: const Transactions(),
          ),
        ),
      );

      // Aguarda fetch
      await tester.runAsync(() async {
        await controller.fetchTransactions();
      });

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Salário'), findsOneWidget);
      expect(find.text('+R\$ 5.000'), findsOneWidget);
    });

    testWidgets('Deve mostrar indicador de carregamento enquanto busca',
        (WidgetTester tester) async {
      when(mockService.getAll(any)).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return [];
      });

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: controller,
            child: const Transactions(),
          ),
        ),
      );

      controller.fetchTransactions();

      // Pump inicial para mostrar o loading
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Avança o tempo do Future
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(); // Garante reconstrução

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
