import 'package:app_money_flow/src/core/routes/auth_guard.dart';
import 'package:app_money_flow/src/pages/profile_setup/create_user_profile.dart';
import 'package:app_money_flow/src/pages/profile_setup/create_user_profile1.dart';
import 'package:app_money_flow/src/pages/home/home.dart';
import 'package:app_money_flow/src/pages/login/login_page.dart';
import 'package:app_money_flow/src/pages/expenses/my_expenses_page.dart';
import 'package:flutter/material.dart';
import '../../pages/register/register_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile-setup';
  static const String profileQuestions = '/profile-questions';
  static const String home = '/home';
  static const String expenses = '/expenses';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => AuthGuard(isPrivate: false, child: LoginScreen()),
      register: (context) => AuthGuard(isPrivate: false, child: RegisterPage()),
      profile: (context) =>
          AuthGuard(isPrivate: true, child: CreateUserProfile()),
      profileQuestions: (context) =>
          AuthGuard(isPrivate: true, child: CreateUserProfile1()),
      home: (context) => AuthGuard(isPrivate: true, child: Home()),
      expenses: (context) =>
          AuthGuard(isPrivate: true, child: MyExpensesPage()),
    };
  }
}
