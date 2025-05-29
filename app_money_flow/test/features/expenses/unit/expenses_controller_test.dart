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

  group('ExpensesController', () {
    test('loadTransactions should load data and update state', () async {
      final now = DateTime.now();
      // Arrange
      final fakeTransactions = [
        TransactionModel(
          id: '1',
          name: 'Jantar',
          value: 90.0,
          date: DateTime(now.year, now.month, 10).toIso8601String(),
          type: TransactionType.expense,
          category: CategoryModel(
            id: 'c1',
            name: 'Alimentação',
            icon: 'food',
          ),
        ),
        TransactionModel(
          id: '2',
          name: 'Café',
          value: 10.0,
          date: DateTime(now.year, now.month, 5).toIso8601String(),
          type: TransactionType.expense,
          category: CategoryModel(
            id: 'c1',
            name: 'Alimentação',
            icon: 'food',
          ),
        ),
      ];

      final fakeAccounts = [
        BankAccountModel(
          id: '1',
          name: 'Conta 1',
          initialBalance: 1000.0,
          type: 'Conta Corrente',
          color: '#000000',
          currentBalance: 2000.0,
        ),
      ];

      when(mockTransactionService.getAll(any))
          .thenAnswer((_) async => fakeTransactions);
      when(mockBankAccountsService.getAll())
          .thenAnswer((_) async => fakeAccounts);
      when(mockMessageService.getMessageForCategory(any))
          .thenAnswer((_) async => 'Dica de economia');

      // Act
      await controller.loadTransactions();

      // Assert
      expect(controller.isLoading, isFalse);
      expect(controller.transactions, isNotEmpty);
      expect(controller.accounts, isNotEmpty);
      expect(controller.categoryMessage, 'Dica de economia');
    });

    test('loadTransactionByCategory should load summary by category', () async {
      // Arrange
      final summary = [
        TransactionByCategoryModel(
          id: '1',
          name: 'Alimentação',
          color: '#FF0000',
          icon:
              'food',
          total: 100.0,
        ),
      ];

      when(mockTransactionService.getExpenseSummaryByCategory(
        month: anyNamed('month'),
        year: anyNamed('year'),
      )).thenAnswer((_) async => summary);

      // Act
      await controller.loadTransactionByCategory();

      // Assert
      expect(controller.transactionByCategory, isNotEmpty);
      expect(controller.transactionByCategory.first.name, 'Alimentação');
    });

    test('getHighestTransactionForMonth should return correct transaction',
        () async {
      final now = DateTime.now();
      final fakeTransactions = [
        TransactionModel(
          id: '1',
          name: 'Jantar',
          value: 90.0,
          date: DateTime(now.year, now.month, 10).toIso8601String(),
          type: TransactionType.expense,
          category: CategoryModel(
            id: 'c1',
            name: 'Alimentação',
            icon: 'food',
          ),
        ),
        TransactionModel(
          id: '2',
          name: 'Café',
          value: 10.0,
          date: DateTime(now.year, now.month, 5).toIso8601String(),
          type: TransactionType.expense,
          category: CategoryModel(
            id: 'c1',
            name: 'Alimentação',
            icon: 'food',
          ),
        ),
      ];

      controller.transactions = fakeTransactions;

      final highest = controller.getHighestTransactionForMonth();
      expect(highest?.name, 'Jantar');
    });
  });
}
