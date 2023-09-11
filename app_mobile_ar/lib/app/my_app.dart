import 'package:app_mobile_ar/app/presentation/routes/app_routes.dart';
import 'package:app_mobile_ar/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.SPLASH,
      routes: appRoutes,
    );
  }
}