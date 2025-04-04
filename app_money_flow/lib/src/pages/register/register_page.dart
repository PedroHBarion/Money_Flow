import 'package:app_money_flow/src/pages/register/register_page_controller.dart';
import 'package:app_money_flow/src/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/routes/app_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _controller = RegisterController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _register() {
    setState(() {
      if (_controller.validateFields()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Conta criada com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/logo_money_flow.svg',
                height: 25,
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'MoneyFlow',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
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
                  GestureDetector(
                    child: InkWell(
                      onTap: () => Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamed(AppRoutes.login),
                      child: const Text(
                        "Fazer Login",
                        style: TextStyle(
                          color: Color(0xFF087F5B),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Input(
                label: 'Nome',
                controller: _controller.nameController,
                errorText: _controller.nameError,
                obscureText: false,
              ),
              const SizedBox(height: 15),
              Input(
                label: 'Email',
                controller: _controller.emailController,
                errorText: _controller.emailError,
                obscureText: false,
              ),
              const SizedBox(height: 15),
              Input(
                label: 'Senha',
                controller: _controller.passwordController,
                errorText: _controller.passwordError,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              Input(
                label: 'Confirmar Senha',
                controller: _controller.confirmPasswordController,
                errorText: _controller.confirmPasswordError,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF087F5B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _register,
                  child: const Text(
                    "Criar Conta",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
