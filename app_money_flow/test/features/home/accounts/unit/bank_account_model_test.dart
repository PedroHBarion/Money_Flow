import 'package:flutter_test/flutter_test.dart';
import 'package:app_money_flow/src/core/models/bank_account_model.dart';

void main() {
  group('BankAccountModel', () {
    final jsonMap = {
      'id': 'abc123',
      'name': 'Conta Teste',
      'type': 'CHECKING',
      'initialBalance': 1500.0,
      'color': '#FFFFFF',
      'currentBalance': 1600.0,
    };

    test('deve criar a instância corretamente', () {
      final account = BankAccountModel(
        id: 'abc123',
        name: 'Conta Teste',
        type: 'CHECKING',
        initialBalance: 1500.0,
        color: '#FFFFFF',
        currentBalance: 1600.0,
      );

      expect(account.id, 'abc123');
      expect(account.name, 'Conta Teste');
      expect(account.type, 'CHECKING');
      expect(account.initialBalance, 1500.0);
      expect(account.color, '#FFFFFF');
      expect(account.currentBalance, 1600.0);
    });

    test('deve converter de JSON corretamente com currentBalance', () {
      final account = BankAccountModel.fromJson(jsonMap);

      expect(account.id, jsonMap['id']);
      expect(account.name, jsonMap['name']);
      expect(account.type, jsonMap['type']);
      expect(account.initialBalance, jsonMap['initialBalance']);
      expect(account.color, jsonMap['color']);
      expect(account.currentBalance, jsonMap['currentBalance']);
    });

    test('deve converter para JSON corretamente para criação', () {
      final account = BankAccountModel(
        name: 'Conta Teste',
        initialBalance: 1500.0,
        type: 'CHECKING',
        color: '#FFFFFF',
      );

      final result = account.createAccountToJson();

      expect(result, {
        'name': 'Conta Teste',
        'initialBalance': 1500.0,
        'type': 'CHECKING',
        'color': '#FFFFFF',
      });
    });

    test('deve converter para JSON corretamente para atualização', () {
      final account = BankAccountModel.fromJson(jsonMap);
      final result = account.updateAccountToJson();

      expect(result, jsonMap);
    });

    test('deve lidar com currentBalance nulo no fromJson', () {
      final jsonWithoutCurrentBalance = {
        'id': 'xyz789',
        'name': 'Conta Simples',
        'type': 'SAVINGS',
        'initialBalance': 2000.0,
        'color': '#000000',
      };

      final account = BankAccountModel.fromJson(jsonWithoutCurrentBalance);

      expect(account.currentBalance, isNull);
    });
  });
}
