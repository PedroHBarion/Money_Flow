import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:app_money_flow/src/core/services/auth_service.dart';

@GenerateMocks([AuthService])
void main() {
  // ----------------------------
  // Funções auxiliares de validação
  // ----------------------------
  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length >= 6;
  }

  // ----------------------------
  // Testes de validação de e-mail
  // ----------------------------
  group('validateEmail', () {
    test('deve aceitar e-mails válidos', () {
      expect(validateEmail('teste@email.com'), isTrue);
      expect(validateEmail('usuario.name@empresa.org'), isTrue);
    });

    test('deve rejeitar e-mails inválidos', () {
      expect(validateEmail('email.com'), isFalse);
      expect(validateEmail('usuario@.com'), isFalse);
      expect(validateEmail(''), isFalse);
    });
  });

  // ----------------------------
  // Testes de validação de senha
  // ----------------------------
  group('validatePassword', () {
    test('deve aceitar senhas com 6 ou mais caracteres', () {
      expect(validatePassword('123456'), isTrue);
      expect(validatePassword('abcdefg'), isTrue);
    });

    test('deve rejeitar senhas com menos de 6 caracteres', () {
      expect(validatePassword('123'), isFalse);
      expect(validatePassword('abc'), isFalse);
    });
  });

  // ----------------------------
  // Testes de validação se as senhas coincidem
  // ----------------------------
  group('Validação local de senha e confirmação', () {
    bool confirmPasswordsMatch(String password, String confirmPassword) {
      return password == confirmPassword;
    }

    test('senhas coincidem', () {
      expect(confirmPasswordsMatch('123456', '123456'), isTrue);
    });

    test('senhas não coincidem', () {
      expect(confirmPasswordsMatch('123456', '654321'), isFalse);
    });
  });
}
