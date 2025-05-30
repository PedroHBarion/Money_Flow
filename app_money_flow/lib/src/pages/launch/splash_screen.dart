import 'package:app_money_flow/src/core/routes/app_routes.dart';
import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:app_money_flow/src/widgets/icons/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  String _statusMessage = "Inicializando...";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    _checkSession();
  }

  Future<void> _checkSession() async {
    setState(() => _statusMessage = "Verificando sessão salva...");

    try {
      final success = await context.read<AuthProvider>().checkAndLoadSession();
      if (!mounted) return;

      if (success) {
        _goToHome();
      } else {
        _goToLogin();
      }
    } catch (e) {
      debugPrint("Erro ao validar sessão: $e");
      context.read<AuthProvider>().signout();
      _goToLogin();
    }
  }

  void _goToHome() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.main, (route) => false);
  }

  void _goToLogin() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF087F5B),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: const Logo(
                  color: Colors.white,
                  fontSize: 26,
                  iconSize: 32,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _statusMessage,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
