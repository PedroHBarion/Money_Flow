import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../../pages/home/home.dart';
import '../../pages/login/login_page.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;
  final bool isPrivate;

  const AuthGuard({
    required this.child,
    this.isPrivate = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final signedIn = context.watch<AuthProvider>().signedIn;

    // Se a rota é privada e o usuário não está logado → redireciona para login
    if (isPrivate && !signedIn) {
      return const LoginScreen();
    }

    // Se a rota é pública e o usuário já está logado → redireciona para home
    if (!isPrivate && signedIn) {
      return const Home();
    }

    // Caso contrário, exibe a rota normalmente
    return child;
  }
}
