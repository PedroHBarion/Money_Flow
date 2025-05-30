import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:app_money_flow/src/pages/register/register_page_controller.dart';
import 'package:app_money_flow/src/widgets/button.dart';
import 'package:app_money_flow/src/widgets/icons/logo.dart';
import 'package:app_money_flow/src/widgets/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';
import '../../core/routes/app_routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = GetIt.I<AuthService>();
    return ChangeNotifierProvider<RegisterController>(
      create: (_) => RegisterController(authService),
      child: const _RegisterForm(),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterController>();

    void handleRegister() {
      if (controller.isLoading) return;
      controller.validateAndRegister(context);
    }

    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Logo(color: Colors.grey, fontSize: 20, iconSize: 25),
          ),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Crie sua conta',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Já possui uma conta? "),
                      InkWell(
                        onTap: () {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamed(AppRoutes.login);
                        },
                        child: const Text(
                          "Fazer Login",
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
                    label: 'Nome',
                    controller: controller.nameController,
                    validator: Validatorless.multiple([
                      Validatorless.required('O nome é obrigatório'),
                      Validatorless.min(3, 'Nome muito curto'),
                    ]),
                  ),
                  const SizedBox(height: 15),
                  Input(
                    label: 'Email',
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
                      Validatorless.min(8, 'Mínimo 8 caracteres'),
                      Validatorless.regex(
                          RegExp(r'[A-Z]'), 'Use uma letra maiúscula'),
                      Validatorless.regex(
                          RegExp(r'[a-z]'), 'Use uma letra minúscula'),
                      Validatorless.regex(RegExp(r'[0-9]'), 'Use um número'),
                      Validatorless.regex(
                          RegExp(r'[^A-Za-z0-9]'), 'Use um caractere especial'),
                    ]),
                  ),
                  const SizedBox(height: 15),
                  Input(
                    label: 'Confirmar Senha',
                    controller: controller.confirmPasswordController,
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('A confirmação é obrigatória'),
                      Validatorless.compare(
                        controller.passwordController,
                        'As senhas devem ser iguais',
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Button(
                    text: 'Criar Conta',
                    isLoading: controller.isLoading,
                    onPressed: () => handleRegister(),
                    disabled: controller.isLoading,
                    variant: ButtonVariant.normal,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
