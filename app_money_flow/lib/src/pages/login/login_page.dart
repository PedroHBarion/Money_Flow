import 'package:app_money_flow/src/core/routes/app_routes.dart';
import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:app_money_flow/src/widgets/button.dart';
import 'package:app_money_flow/src/widgets/icons/logo.dart';
import 'package:app_money_flow/src/widgets/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';
import 'login_page_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = GetIt.I<AuthService>();

    return ChangeNotifierProvider<LoginController>(
      create: (_) => LoginController(authService),
      child: const _LoginForm(),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LoginController>();

    void handleSignin() {
      if (controller.isLoading) return;

      controller.validateAndLogin(context);
    }

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Logo(
              color: Colors.grey,
              fontSize: 20,
              iconSize: 25,
            )),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: controller.formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Entre em sua conta',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Não possui uma conta? "),
                    InkWell(
                      onTap: () {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamed(AppRoutes.register);
                      },
                      child: const Text(
                        "Crie uma aqui",
                        style: TextStyle(
                          color: Color(0xFF087F5B),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Input(
                  label: 'E-mail',
                  controller: controller.emailController,
                  validator: Validatorless.multiple([
                    Validatorless.required('O e-mail é obrigatório'),
                    Validatorless.email('E-mail inválido'),
                  ]),
                ),
                const SizedBox(height: 15),
                Input(
                  label: 'Senha',
                  controller: controller.passwordController,
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.required('A senha é obrigatória'),
                    Validatorless.regex(RegExp(r'^\d{8}$'),
                        'A senha deve conter exatamente 8 números'),
                  ]),
                ),
                const SizedBox(height: 20),
                Button(
                  text: 'Entrar',
                  isLoading: controller.isLoading,
                  onPressed: () => handleSignin(),
                  disabled: controller.isLoading,
                  variant: ButtonVariant.normal,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
