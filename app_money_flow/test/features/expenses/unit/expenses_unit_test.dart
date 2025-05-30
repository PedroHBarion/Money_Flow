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

  test('loadTransactions returns expenses and loads correct category message',
      () async {
    final now = DateTime.now();

    // Mock despesas
    final fakeTransactions = [
      TransactionModel(
        id: '1',
        name: 'Almoço',
        value: 50.0,
        date: DateTime(now.year, now.month, 3).toIso8601String(),
        type: TransactionType.expense,
        category: CategoryModel(
          id: 'cat1',
          name: 'Alimentação',
          icon: 'food',
        ),
      ),
      TransactionModel(
        id: '2',
        name: 'Cinema',
        value: 30.0,
        date: DateTime(now.year, now.month, 15).toIso8601String(),
        type: TransactionType.expense,
        category: CategoryModel(
          id: 'cat2',
          name: 'Lazer',
          icon: 'movie',
        ),
      ),
      TransactionModel(
        id: '3',
        name: 'Taxi',
        value: 20.0,
        date: DateTime(now.year, now.month, 20).toIso8601String(),
        type: TransactionType.expense,
        category: CategoryModel(
          id: 'cat3',
          name: 'Transporte',
          icon: 'car',
        ),
      ),
    ];

    // Mock contas bancárias
    final fakeAccounts = [
      BankAccountModel(
        id: 'acc1',
        name: 'Conta Principal',
        initialBalance: 1000.0,
        type: 'Conta Corrente',
        color: '#00FF00',
        currentBalance: 1500.0,
      ),
    ];

    // Mock resumo por categoria (total por categoria)
    final summaryByCategory = [
      TransactionByCategoryModel(
        id: 'cat1',
        name: 'Alimentação',
        color: '#FF6347', // tom vermelho tomate
        icon: 'food',
        total: 50.0,
      ),
      TransactionByCategoryModel(
        id: 'cat2',
        name: 'Lazer',
        color: '#1E90FF', // tom azul dodger
        icon: 'movie',
        total: 30.0,
      ),
      TransactionByCategoryModel(
        id: 'cat3',
        name: 'Transporte',
        color: '#32CD32', // tom verde lima
        icon: 'car',
        total: 20.0,
      ),
    ];

    // Arrange: configurar os retornos dos mocks
    when(mockTransactionService.getAll(any))
        .thenAnswer((_) async => fakeTransactions);

    when(mockBankAccountsService.getAll())
        .thenAnswer((_) async => fakeAccounts);

    when(mockTransactionService.getExpenseSummaryByCategory(
      month: anyNamed('month'),
      year: anyNamed('year'),
    )).thenAnswer((_) async => summaryByCategory);

    // Mockar retorno da mensagem da categoria mais alta (Alimentação - 50)
    when(mockMessageService.getMessageForCategory('Alimentação')).thenAnswer(
        (_) async =>
            'Você gastou mais com alimentação este mês. Que tal buscar opções mais econômicas e saudáveis? 🍎🍽️');

    // Act: carregar os dados
    await controller.loadTransactions();

    // Assert: validar estados e mensagens
    expect(controller.isLoading, isFalse);
    expect(controller.transactions, hasLength(3));
    expect(controller.accounts, hasLength(1));
    expect(controller.transactionByCategory, hasLength(3));
    expect(controller.categoryMessage,
        'Você gastou mais com alimentação este mês. Que tal buscar opções mais econômicas e saudáveis? 🍎🍽️');

    // Validar que o total de despesas calculado bate com o esperado
    expect(controller.totalExpenses(), 100.0);

    // Validar total saldo bancário
    expect(controller.getTotalBalance(), 1500.0);
  });
}
