import 'package:app_money_flow/src/core/models/login_model.dart';
import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = GetIt.I<AuthService>();

  bool obscurePassword = true;
  String? emailError;
  String? passwordError;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}",
    );
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final passwordRegex = RegExp(r"^\d{8}$");
    return passwordRegex.hasMatch(password);
  }

  Future<void> validateAndLogin(BuildContext context) async {
    emailError = null;
    passwordError = null;

    if (emailController.text.isEmpty) {
      emailError = "O e-mail é obrigatório";
    } else if (!isValidEmail(emailController.text)) {
      emailError = "E-mail inválido";
    }

    if (passwordController.text.isEmpty) {
      passwordError = "A senha é obrigatória";
    } else if (!isValidPassword(passwordController.text)) {
      passwordError = "Senha inválida";
    }

    if (emailError == null && passwordError == null) {
      final loginData = LoginModel(
        email: emailController.text,
        password: passwordController.text,
      );
     
      final response = await authService.signin(loginData);

      print(response);

    }
  }

  void dispose() {}
}
