import 'package:app_money_flow/src/core/enums/transaction_type.dart';
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

  group('TransactionsController Unit Tests', () {
    final testTransactions = [
      TransactionModel(
        id: '1',
        name: 'Compra teste',
        value: 50.0,
        date: '2025-05-21',
        type: TransactionType.expense,
      ),
      TransactionModel(
        id: '2',
        name: 'Venda teste',
        value: 100.0,
        date: '2025-05-21',
        type: TransactionType.income,
      ),
    ];

    test('fetchTransactions deve popular transactions e setar isLoading',
        () async {
      when(mockService.getAll(any)).thenAnswer((_) async => testTransactions);

      final future = controller.fetchTransactions();

      expect(controller.isLoading,
          true); // isLoading deve ser true logo após chamada

      await future;

      expect(controller.transactions, testTransactions);
      expect(controller.isLoading, false);
      verify(mockService.getAll(any)).called(1);
    });

    test(
        'setAccount deve setar selectedBankAccountId e chamar fetchTransactions',
        () async {
      when(mockService.getAll(any)).thenAnswer((_) async => testTransactions);

      controller.setAccount('123');

      expect(controller.selectedBankAccountId, '123');
      verify(mockService.getAll(any)).called(1);
    });

    test('applyFilters deve aplicar filtros e chamar fetchTransactions',
        () async {
      when(mockService.getAll(any)).thenAnswer((_) async => testTransactions);

      controller.tempAccount = 'abc';
      controller.tempYear = 2023;

      controller.applyFilters();

      expect(controller.selectedBankAccountId, 'abc');
      expect(controller.selectedYear, 2023);
      verify(mockService.getAll(any)).called(1);
    });

    test('clearFilters deve limpar filtros e chamar fetchTransactions',
        () async {
      when(mockService.getAll(any)).thenAnswer((_) async => testTransactions);

      controller.clearFilters();

      expect(controller.tempAccount, null);
      expect(controller.tempYear, DateTime.now().year);
      expect(controller.selectedBankAccountId, null);
      expect(controller.selectedYear, DateTime.now().year);
      verify(mockService.getAll(any)).called(1);
    });

    test(
        'changeMonth deve alterar currentMonthIndex e chamar fetchTransactions',
        () async {
      when(mockService.getAll(any)).thenAnswer((_) async => testTransactions);

      int newMonth = 5;

      controller.changeMonth(newMonth);

      expect(controller.currentMonthIndex, newMonth);
      verify(mockService.getAll(any)).called(1);
    });

    test(
        'setTransactionType deve setar selectedType e chamar fetchTransactions',
        () async {
      when(mockService.getAll(any)).thenAnswer((_) async => testTransactions);

      controller.setTransactionType(TransactionType.income);

      expect(controller.selectedType, TransactionType.income);
      verify(mockService.getAll(any)).called(1);
    });
  });
}
