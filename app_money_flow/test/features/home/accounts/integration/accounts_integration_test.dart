import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:app_money_flow/src/core/services/bank_accounts_service.dart';
import 'package:app_money_flow/src/core/models/bank_account_model.dart';

import '../mock/accounts.mocks.dart';

@GenerateMocks([BankAccountsService])
void main() {
  late AccountsController controller;
  late MockBankAccountsService mockService;

  final fakeAccounts = [
    BankAccountModel(
      id: "1",
      name: 'Conta A',
      type: "CHECKING",
      initialBalance: 500.0,
      color: "#333333",
    ),
    BankAccountModel(
      id: "2",
      name: 'Conta B',
      type: "INVESTMENT",
      initialBalance: 1000.0,
      color: "#666666",
    ),
  ];

  setUp(() {
    mockService = MockBankAccountsService();
    controller = AccountsController(service: mockService);
  });

  group('Accounts Integration Test', () {
    test('Deve integrar controller e service com mock e retornar dados',
        () async {
      when(mockService.getAll()).thenAnswer((_) async => fakeAccounts);

      await controller.loadAccounts();

      expect(controller.isLoading, false);
      expect(controller.accounts.length, fakeAccounts.length);

      for (int i = 0; i < fakeAccounts.length; i++) {
        expect(controller.accounts[i].id, fakeAccounts[i].id);
        expect(controller.accounts[i].name, fakeAccounts[i].name);
        expect(controller.accounts[i].type, fakeAccounts[i].type);
        expect(controller.accounts[i].initialBalance,
            fakeAccounts[i].initialBalance);
        expect(controller.accounts[i].color, fakeAccounts[i].color);
      }

      verify(mockService.getAll()).called(1);
    });

    test('Deve lidar com resposta vazia do service', () async {
      when(mockService.getAll()).thenAnswer((_) async => []);

      await controller.loadAccounts();

      expect(controller.isLoading, false);
      expect(controller.accounts, isEmpty);

      verify(mockService.getAll()).called(1);
    });

    test('Deve tratar erro lançado pelo service', () async {
      when(mockService.getAll()).thenThrow(Exception('Erro no service'));

      await controller.loadAccounts();

      expect(controller.isLoading, false);
      expect(controller.accounts, isEmpty);

      verify(mockService.getAll()).called(1);
    });
  });
}
