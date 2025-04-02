import 'package:app_money_flow/src/core/models/register_model.dart';
import 'package:flutter/material.dart';

class RegisterController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  bool _isValidName(String name) {
    return RegExp(r"^[a-zA-Z\s]").hasMatch(name);
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}",
    );
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r"^\d{8}$");
    return passwordRegex.hasMatch(password);
  }

  bool validateFields() {
    nameError = null;
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;

    if (nameController.text.isEmpty) {
      nameError = "O nome é obrigatório";
    } else if (!_isValidName(nameController.text)) {
      nameError = "Nome inválido";
    }

    if (emailController.text.isEmpty) {
      emailError = "O e-mail é obrigatório";
    } else if (!_isValidEmail(emailController.text)) {
      emailError = "E-mail inválido";
    }

    if (passwordController.text.isEmpty) {
      passwordError = "A senha é obrigatória";
    } else if (!_isValidPassword(passwordController.text)) {
      passwordError = "Senha inválida";
    }

    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError = "A confirmação de senha é obrigatória";
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError = "As senhas precisam ser iguais";
    }

    if (emailError == null && passwordError == null) {
      final user = RegisterModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      final userDataJson = user.toJson();
      print(userDataJson);
    }

    return nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;
  }
}
