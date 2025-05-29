import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_filters_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:app_money_flow/src/pages/home/widgets/transactions/transactions_controller.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_model.dart';
import '../mock/transactions.mocks.dart';

void main() {
  late TransactionsController controller;
  late MockTransactionService mockService;

  setUp(() {
    mockService = MockTransactionService();
    controller = TransactionsController(service: mockService);
  });

  test('Deve notificar listeners ao buscar transações', () async {
    final testTransactions = [
      TransactionModel(
          id: '1',
          name: 'Teste',
          value: 10,
          date: '2025-05-21',
          type: TransactionType.income),
    ];

    when(mockService.getAll(any)).thenAnswer((_) async => testTransactions);

    int notifyCount = 0;
    controller.addListener(() {
      notifyCount++;
    });

    await controller.fetchTransactions();

    expect(controller.transactions, testTransactions);
    expect(notifyCount, greaterThan(0),
        reason: 'Listeners devem ser notificados quando o estado muda');
  });

  test('applyFilters deve aplicar filtros e recarregar transações', () async {
    when(mockService.getAll(any)).thenAnswer((invocation) async {
      final filters =
          invocation.positionalArguments[0] as TransactionFiltersModel;
      expect(filters.bankAccountId, 'acc123');
      expect(filters.year, 2024);
      return [
        TransactionModel(
            id: '2',
            name: 'Com Filtro',
            value: 200,
            date: '2025-05-22',
            type: TransactionType.expense),
      ];
    });

    controller.setTempAccount('acc123');
    controller.setTempYear(2024);

    await controller.applyFilters();

    expect(controller.selectedBankAccountId, 'acc123');
    expect(controller.selectedYear, 2024);
    expect(controller.transactions.length, 1);
    expect(controller.transactions.first.name, 'Com Filtro');
  });

  test('changeMonth deve alterar o mês e recarregar as transações', () async {
    when(mockService.getAll(any)).thenAnswer((_) async => [
          TransactionModel(
              id: '3',
              name: 'Novo Mês',
              value: 300,
              date: '2025-06-01',
              type: TransactionType.income),
        ]);

    await controller.changeMonth(5); // Junho

    expect(controller.currentMonthIndex, 5);
    expect(controller.transactions.length, 1);
    expect(controller.transactions.first.name, 'Novo Mês');
  });

  test('setTransactionType deve filtrar por tipo e buscar novamente', () async {
    when(mockService.getAll(any)).thenAnswer((invocation) async {
      final filters =
          invocation.positionalArguments[0] as TransactionFiltersModel;
      expect(filters.type, 'INCOME');
      return [
        TransactionModel(
            id: '4',
            name: 'Receita',
            value: 400,
            date: '2025-07-10',
            type: TransactionType.income),
      ];
    });

    await controller.setTransactionType(TransactionType.income);

    expect(controller.selectedType, TransactionType.income);
    expect(controller.transactions.length, 1);
    expect(controller.transactions.first.name, 'Receita');
  });

  test('clearFilters deve resetar filtros e recarregar as transações',
      () async {
    when(mockService.getAll(any)).thenAnswer((invocation) async {
      final filters =
          invocation.positionalArguments[0] as TransactionFiltersModel;
      expect(filters.bankAccountId, isNull);
      expect(filters.year, DateTime.now().year);
      return [
        TransactionModel(
            id: '5',
            name: 'Resetado',
            value: 500,
            date: '2025-08-01',
            type: TransactionType.expense),
      ];
    });

    controller.selectedBankAccountId = 'teste';
    controller.selectedYear = 2024;
    controller.tempAccount = 'teste';
    controller.tempYear = 2024;

    await controller.clearFilters();

    expect(controller.selectedBankAccountId, isNull);
    expect(controller.selectedYear, DateTime.now().year);
    expect(controller.transactions.first.name, 'Resetado');
  });
}
