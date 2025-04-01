<<<<<<< Updated upstream:app_money_flow/lib/src/pages/login_page.dart
import 'package:app_money_flow/src/pages/create_account_page.dart';
=======
import 'package:app_money_flow/src/core/routes/app_routes.dart';
>>>>>>> Stashed changes:app_money_flow/lib/src/pages/login/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../login/login_controller.dart';
import '../core/routes/app_routes.dart';
import 'package:app_money_flow/src/widgets/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = LoginController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

<<<<<<< Updated upstream:app_money_flow/lib/src/pages/login_page.dart
  // Validação de e-mail
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email);
  }

  // Validação de senha (8 números)
  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r"^\d{8}$");
    return passwordRegex.hasMatch(password);
  }

  void _validateAndLogin() {
    setState(() {
      _emailError = null;
      _passwordError = null;

      if (emailController.text.isEmpty) {
        _emailError = "O e-mail é obrigatório";
      } else if (!_isValidEmail(emailController.text)) {
        _emailError = "E-mail inválido";
      }

      if (passwordController.text.isEmpty) {
        _passwordError = "A senha é obrigatória";
      } else if (!_isValidPassword(passwordController.text)) {
        _passwordError = "Senha inválida";
      }
    });

    if (_emailError == null && _passwordError == null) {
      // Autenticação bem-sucedida
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login realizado com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

=======
>>>>>>> Stashed changes:app_money_flow/lib/src/pages/login/login_page.dart
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
        child: Form(
          key: _controller.formKey,
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
                    GestureDetector(
                      child: InkWell(
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
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Input(
                  label: 'Email',
                  controller: _controller.emailController,
                  errorText: _controller.emailError,
                ),
                // TextField(
                //   controller: _controller.emailController,
                //   decoration: InputDecoration(
                //     labelText: "E-mail",
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     errorText: _controller.emailError,
                //   ),
                //   keyboardType: TextInputType.emailAddress,
                // ),
                const SizedBox(height: 15),
                TextField(
                  controller: _controller.passwordController,
                  obscureText: _controller.obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: _controller.passwordError,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _controller.obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.togglePasswordVisibility();
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.number,
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
                    onPressed: () {
                      setState(() {
                        _controller.validateAndLogin(context);
                      });
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
