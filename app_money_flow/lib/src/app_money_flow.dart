import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'core/routes/app_routes.dart';
import 'core/services/toast_service.dart'; // ajuste conforme seu path
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
        canvasColor: Color(0xffFFFFFF), 
      ),
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
        localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'Money Flow',
      navigatorKey: navigatorKey,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      builder: (context, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final overlay = navigatorKey.currentState?.overlay;
          if (overlay != null && !GetIt.I<ToastService>().isInitialized) {
            GetIt.I<ToastService>().init(overlay);
          }
        });
        return child!;
      },
    );
  }
}
