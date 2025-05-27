import 'package:flutter_test/flutter_test.dart';

/// Simula a função que valida os dados do perfil do usuário
bool validateUserProfileData({required String name, required double goal}) {
  if (name.isEmpty) return false;
  if (goal <= 0) return false;
  return true;
}

void main() {
  group('validateUserProfileData - Teste Unitário (Caixa Branca)', () {
    test('Retorna false se o nome for vazio', () {
      final result = validateUserProfileData(name: '', goal: 100.0);
      expect(result, false);
    });

    test('Retorna false se a meta for menor ou igual a zero', () {
      final result = validateUserProfileData(name: 'Pedro', goal: 0.0);
      expect(result, false);
    });

    test('Retorna true se nome for válido e meta positiva', () {
      final result = validateUserProfileData(name: 'Pedro', goal: 500.0);
      expect(result, true);
    });
  });
}

// Teste Caixa- Branca