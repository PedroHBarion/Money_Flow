import 'package:app_money_flow/src/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

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

    if (isPrivate && !signedIn) {
      Future.microtask(() => Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.login,
            (route) => false,
          ));
      return const SizedBox.shrink();
    }

    // if (!isPrivate && signedIn) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.of(context).pushNamedAndRemoveUntil(
    //       AppRoutes.main,
    //       (route) => false,
    //     );
    //   });
    //   return const SizedBox.shrink();
    // }
    return child;
  }
}
