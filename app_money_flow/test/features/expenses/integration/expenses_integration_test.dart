import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:app_money_flow/src/pages/expenses/expense_controller.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_model.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_by_category_model.dart';
import 'package:app_money_flow/src/core/models/bank_account_model.dart';
import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/core/models/category_model.dart';

import '../mocks/expenses.mocks.dart';

void main() {
  late ExpensesController controller;
  late MockTransactionService mockTransactionService;
  late MockBankAccountsService mockBankAccountsService;
  late MockMessageService mockMessageService;

  setUp(() {
    mockTransactionService = MockTransactionService();
    mockBankAccountsService = MockBankAccountsService();
    mockMessageService = MockMessageService();

    controller = ExpensesController(
      mockTransactionService,
      mockBankAccountsService,
      mockMessageService,
    );
  });

  group('ExpensesController Integration-like Tests with Mocks', () {
    test('should load all data and update state', () async {
      final now = DateTime.now();

      // Dados simulados
      final fakeTransactions = [
        TransactionModel(
          id: '1',
          name: 'Almoço',
          value: 45.0,
          date: DateTime(now.year, now.month, 8).toIso8601String(),
          type: TransactionType.expense,
          category: CategoryModel(id: 'c1', name: 'Alimentação', icon: 'food'),
        ),
      ];

      final fakeAccounts = [
        BankAccountModel(
          id: 'acc1',
          name: 'Conta Teste',
          initialBalance: 500.0,
          type: 'Conta Corrente',
          color: '#123456',
          currentBalance: 800.0,
        ),
      ];

      final fakeSummary = [
        TransactionByCategoryModel(
          id: 'c1',
          name: 'Alimentação',
          color: '#FF0000',
          icon: 'food',
          total: 120.0,
        ),
      ];

      // Mocks
      when(mockTransactionService.getAll(any))
          .thenAnswer((_) async => fakeTransactions);

      when(mockBankAccountsService.getAll())
          .thenAnswer((_) async => fakeAccounts);

      when(mockTransactionService.getExpenseSummaryByCategory(
              month: anyNamed('month'), year: anyNamed('year')))
          .thenAnswer((_) async => fakeSummary);

      when(mockMessageService.getMessageForCategory('Alimentação'))
          .thenAnswer((_) async => 'Dica de economia mockada');

      // Execução
      await controller.loadTransactions();

      // Validações
      expect(controller.isLoading, isFalse);
      expect(controller.transactions, isNotEmpty);
      expect(controller.accounts, isNotEmpty);
      expect(controller.transactionByCategory, isNotEmpty);
      expect(controller.categoryMessage, 'Dica de economia mockada');
    });

    test('should return highest transaction from mocked data', () async {
      final fakeSummary = [
        TransactionByCategoryModel(
          id: 'c2',
          name: 'Lazer',
          color: '#00FF00',
          icon: 'game',
          total: 200.0,
        ),
        TransactionByCategoryModel(
          id: 'c3',
          name: 'Transporte',
          color: '#0000FF',
          icon: 'car',
          total: 100.0,
        ),
      ];

      controller.transactionByCategory = fakeSummary;

      final highest = controller.getHighestCategoryExpense();

      expect(highest, isNotNull);
      expect(highest!.name, 'Lazer');
      expect(highest.total, 200.0);
    });
  });
}
