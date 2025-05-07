import 'package:app_money_flow/src/core/services/secure_storage_service.dart';
import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthProvider with ChangeNotifier {
  bool _signedIn = false;
  bool get signedIn => _signedIn;

  final AuthService authService = GetIt.I<AuthService>();

  UserModel? _user;
  UserModel? get user => _user;

  AuthProvider() {
    checkAndLoadSession();
  }

  /// Verifica o token e carrega o status da autenticação
  Future<bool> checkAndLoadSession() async {
    final token = await SecureStorageService.readToken();

    if (token != null) {
      final user = await authService.validateToken(token);

      if (user != null) {
        _signedIn = true;
        _user = user;
        notifyListeners();
        await Future.delayed(Duration(milliseconds: 150));
        return true;
      } else {
        await signout();
        return false;
      }
    }
    return false;
  }

  /// Faz o login do usuário, escrevendo o token no armazenamento seguro
  Future<void> signin(String accessToken) async {
    await SecureStorageService.writeToken(accessToken);
    _signedIn = true;
    notifyListeners();
  }

  /// Realiza o logout do usuário, excluindo o token e limpando o estado
  Future<void> signout() async {
    await SecureStorageService.deleteToken();
    _signedIn = false;
    _user = null;
    notifyListeners();
  }
}
