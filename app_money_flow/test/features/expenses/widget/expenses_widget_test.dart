import 'package:app_money_flow/src/core/models/bank_account_model.dart';
import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:app_money_flow/src/pages/expenses/expenses_page.dart';
import 'package:app_money_flow/src/pages/expenses/expense_controller.dart';
import 'package:app_money_flow/src/core/services/transactions_service.dart';
import 'package:app_money_flow/src/core/services/bank_accounts_service.dart';
import 'package:app_money_flow/src/core/services/message_service.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_model.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_by_category_model.dart';
import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/pages/expenses/widgets/empty_state_widget.dart';
import 'package:app_money_flow/src/core/models/category_model.dart';

// Mocks gerados manualmente ou usando mockito codegen
class MockTransactionService extends Mock implements TransactionService {}

class MockBankAccountsService extends Mock implements BankAccountsService {}

class MockMessageService extends Mock implements MessageService {}

class MockAuthProvider extends Mock implements AuthProvider, ChangeNotifier {}

class FakeAuthProvider extends ChangeNotifier implements AuthProvider {
  @override
  UserModel get user => UserModel(name: 'Bruno', email: 'bruno@gmail.com');

  @override
  bool get signedIn => true;

  @override
  Future<bool> checkAndLoadSession() async {
    return true;
  }

  @override
  Future<void> signin(String token) async {
    // Não faz nada para teste
  }

  @override
  Future<void> signout() async {
    // Falso logout
  }

  @override
  AuthService get authService => throw UnimplementedError('Não usado no teste');
}

void main() {
  late ExpensesController controller;
  late MockTransactionService mockTransactionService;
  late MockBankAccountsService mockBankAccountsService;
  late MockMessageService mockMessageService;

  late FakeAuthProvider fakeAuthProvider;
// substitui MockAuthProvider mockAuthProvider;

  setUp(() {
    fakeAuthProvider = FakeAuthProvider(); // novo

    mockTransactionService = MockTransactionService();
    mockBankAccountsService = MockBankAccountsService();
    mockMessageService = MockMessageService();

    controller = ExpensesController(
      mockTransactionService,
      mockBankAccountsService,
      mockMessageService,
    );
  });

  Future<void> pumpExpensesPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ExpensesController>.value(value: controller),
          ChangeNotifierProvider<AuthProvider>.value(value: fakeAuthProvider),
        ],
        child: const MaterialApp(home: ExpensesPage()),
      ),
    );
  }

  testWidgets('Mostra loading indicator quando isLoading true', (tester) async {
    controller.isLoading = true;
    await pumpExpensesPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Mostra EmptyStateWidget quando lista de transações vazia',
      (tester) async {
    controller.isLoading = false;
    controller.transactions = [];
    controller.transactionByCategory = [];
    controller.categoryMessage = null;

    controller.notifyListeners();

    await pumpExpensesPage(tester);
    await tester.pumpAndSettle();

    expect(find.byType(EmptyStateWidget), findsWidgets);
    expect(find.text('Nenhum gasto registrado neste mês.'), findsOneWidget);
  });

  testWidgets('Mostra dados corretamente quando há transações e categorias',
      (tester) async {
    controller.isLoading = false;

    controller.accounts = [
      BankAccountModel(
        id: "1",
        name: 'Conta 1',
        currentBalance: 1000.0,
        initialBalance: 100.0,
        type: '',
        color: '',
      ),
    ];

    controller.transactions = [
      TransactionModel(
        id: "1",
        name: 'Almoço',
        type: TransactionType.expense,
        date: DateTime.now().toIso8601String(),
        value: 200,
        category:
            CategoryModel(id: 'cat1', name: 'Alimentação', icon: 'icon_food'),
      ),
      TransactionModel(
        id: "2",
        name: 'Aluguel',
        type: TransactionType.expense,
        date: DateTime.now().toIso8601String(),
        value: 500,
        category: CategoryModel(id: 'cat2', name: 'Moradia', icon: 'icon_home'),
      ),
    ];

    controller.transactionByCategory = [
      TransactionByCategoryModel(
        name: 'Alimentação',
        total: 200,
        color: '#FF0000',
        id: 'cat1',
        icon: 'icon_food',
      ),
      TransactionByCategoryModel(
        name: 'Moradia',
        total: 500,
        color: '#00FF00',
        id: 'cat2',
        icon: 'icon_home',
      ),
    ];

    controller.categoryMessage = 'Sugestão de economia para Moradia';

    controller.notifyListeners();

    await pumpExpensesPage(tester);
    await tester.pumpAndSettle();

    expect(find.textContaining('R\$ 1.000'), findsOneWidget);
    expect(find.textContaining('R\$ 700'), findsOneWidget);

    expect(find.byType(PieChart), findsOneWidget);
    expect(find.text('Principal Gasto'), findsOneWidget);
    expect(find.text('Moradia'), findsOneWidget);
    expect(find.text('Sugestão de economia para Moradia'), findsOneWidget);
  });
}
