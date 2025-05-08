import 'package:app_money_flow/src/core/models/register_model.dart';
import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:app_money_flow/src/core/routes/app_routes.dart';
import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:app_money_flow/src/core/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class RegisterController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = GetIt.I<AuthService>();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  Future<void> validateAndRegister(BuildContext context) async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    final registerData = RegisterModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    await handleRegister(context, registerData);
  }

  Future<void> handleRegister(BuildContext context, RegisterModel data) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await authService.signup(data);

      await context.read<AuthProvider>().signin(response);

      Toast.success('Conta criada com sucesso!');

      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        AppRoutes.profile,
        (route) => false,
      );
    } catch (e) {
      Toast.error('Erro ao criar conta. Verifique os dados!');
      debugPrint("Erro ao registrar: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
