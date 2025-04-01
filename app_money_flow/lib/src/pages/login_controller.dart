import 'package:flutter/material.dart';
import '../models/login_model.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  String? emailError;
  String? passwordError;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}");
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final passwordRegex = RegExp(r"^\d{8}$");
    return passwordRegex.hasMatch(password);
  }

  void validateAndLogin(BuildContext context) {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login realizado com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void dispose() {}
}
