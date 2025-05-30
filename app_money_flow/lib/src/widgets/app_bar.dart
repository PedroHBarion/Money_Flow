import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:app_money_flow/src/core/utils/show_toast.dart';
import 'package:app_money_flow/src/widgets/icons/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  void _logout(BuildContext context) {
    try {
      context.read<AuthProvider>().signout();
      Toast.success('Logout realizado com sucesso!');
    } catch (e) {
      Toast.error('Erro ao realizar logout');
      debugPrint("Erro ao realizar logout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user!;
    final initials = _getInitials(user.name);

    return Container(
      color: const Color(0xFFFFFFFF),
      margin: const EdgeInsets.only(top: 32, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Logo(
            color: Color(0xFF087F5B),
            fontSize: 18,
            iconSize: 24,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') _logout(context);
            },
            itemBuilder: (_) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Sair'),
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF087F5B),
              radius: 18,
              child: Text(
                initials,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Extrai as duas primeiras letras do nome do usuário
  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts.first.substring(0, 2).toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}
