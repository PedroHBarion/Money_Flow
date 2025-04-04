import 'package:app_money_flow/src/core/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  bool _signedIn = false;
  bool get signedIn => _signedIn;
  final AuthService authService = GetIt.I<AuthService>();

  AuthProvider() {
    _loadAuthStatus();
  }

  Future<void> _loadAuthStatus() async {
    final token = await SecureStorageService.readToken();

    if (token != null) {
      final isValid = await authService.validateToken(token);
      _signedIn = isValid;
      notifyListeners();
    }

    print(_signedIn);
  }

  Future<void> signin(String accessToken) async {
    await SecureStorageService.writeToken(accessToken);
    _signedIn = true;
    notifyListeners();
  }

  Future<void> signout() async {
    await SecureStorageService.deleteToken();
    _signedIn = false;
    notifyListeners();
  }
}
