import 'package:app_money_flow/src/core/models/login_model.dart';
import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:app_money_flow/src/widgets/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = GetIt.I<AuthService>();

  bool obscurePassword = true;
  String? emailError;
  String? passwordError;
  bool isLoading = false;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
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
    notifyListeners();

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

    notifyListeners();

    if (emailError == null && passwordError == null) {
      final loginData = LoginModel(
        email: emailController.text,
        password: passwordController.text,
      );

      await handleLogin(context, loginData);
    }
  }

  Future<void> handleLogin(BuildContext context, LoginModel loginData) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await authService.signin(loginData);

      await context.read<AuthProvider>().signin(response);

      showToast(context, "Login realizado com sucesso!", ToastType.success);
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      showToast(context, "Login inválido. Verifique suas credenciais.", ToastType.error);
      debugPrint("Erro ao realizar login: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
