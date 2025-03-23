import 'package:flutter/material.dart';
import 'core/routes/app_routes.dart'; 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Flow',
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
