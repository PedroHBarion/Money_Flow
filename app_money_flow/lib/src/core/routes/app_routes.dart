import 'package:app_money_flow/src/core/routes/auth_guard.dart';
import 'package:app_money_flow/src/pages/launch/splash_screen.dart';
import 'package:app_money_flow/src/pages/profile_setup/profile_flow_page.dart';
import 'package:app_money_flow/src/pages/login/login_page.dart';
import 'package:app_money_flow/src/core/routes/main_navigation.dart';
import 'package:flutter/material.dart';
import '../../pages/register/register_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String main = '/main';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      login: (context) => AuthGuard(isPrivate: false, child: LoginScreen()),
      register: (context) => AuthGuard(isPrivate: false, child: RegisterPage()),
      profile: (context) =>
          AuthGuard(isPrivate: true, child: ProfileFlowPage()),
      main: (context) => AuthGuard(isPrivate: true, child: MainNavigation()),
    };
  }
}
