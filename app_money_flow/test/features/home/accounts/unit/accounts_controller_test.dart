import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_money_flow/src/core/services/bank_accounts_service.dart';
import 'package:app_money_flow/src/core/models/bank_account_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

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
      color: "#333",
    ),
    BankAccountModel(
      id: "2",
      name: 'Conta B ',
      type: "INVESTMENT",
      initialBalance: 1000.0,
      color: "#333",
    ),
  ];

  setUp(() {
    mockService = MockBankAccountsService();
    controller = AccountsController(service: mockService);
  });

  group('AccountsController', () {
    test('deve iniciar com estado inicial correto', () {
      expect(controller.isLoading, false);
      expect(controller.accounts, []);
    });

    test('deve alternar visibilidade com toggleHidden', () {
      var notified = false;
      controller.addListener(() => notified = true);

      final initial = controller.isHidden;
      controller.toggleHidden();

      expect(controller.isHidden, !initial);
      expect(notified, true);
    });

    test('deve definir isLoading = true ao iniciar carregamento', () async {
      when(mockService.getAll()).thenAnswer((_) async => fakeAccounts);

      final future = controller.loadAccounts();

      expect(controller.isLoading, true);

      await future;
    });

    test('deve carregar lista de contas com sucesso', () async {
      when(mockService.getAll()).thenAnswer((_) async => fakeAccounts);

      await controller.loadAccounts();

      expect(controller.isLoading, false);
      expect(controller.accounts.length, 2);
      expect(controller.accounts[0].name, 'Conta A');
    });

    test('deve lidar com erro no carregamento de contas', () async {
      when(mockService.getAll()).thenThrow(Exception('Erro ao carregar'));

      await controller.loadAccounts();

      expect(controller.isLoading, false);
      expect(controller.accounts, []);
    });

    test('deve notificar listeners após carregar dados', () async {
      var notified = false;
      controller.addListener(() => notified = true);

      when(mockService.getAll()).thenAnswer((_) async => fakeAccounts);

      await controller.loadAccounts();

      expect(notified, true);
    });
  });
}
