import 'package:app_money_flow/src/core/models/login_model.dart';
import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:app_money_flow/src/core/routes/app_routes.dart';
import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:app_money_flow/src/core/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = GetIt.I<AuthService>();

  bool obscurePassword = true;
  bool isLoading = false;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> validateAndLogin(BuildContext context) async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    final loginData = LoginModel(
      email: emailController.text,
      password: passwordController.text,
    );

    await handleLogin(context, loginData);
  }

  Future<void> handleLogin(BuildContext context, LoginModel loginData) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await authService.signin(loginData);

      await context.read<AuthProvider>().signin(response);

      Toast.success('Login realizado com sucesso!');

      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        AppRoutes.main,
        (route) => false,
      );
    } catch (e) {
      Toast.error('Login inválido. Verifique suas credenciais!');
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
