import 'package:app_mobile_ar/app/presentation/modules/home/views/home_view.dart';
import 'package:app_mobile_ar/app/presentation/modules/sign_in/views/sign_in_view.dart';
import 'package:app_mobile_ar/app/presentation/modules/splash/views/splash_view.dart';
import 'package:app_mobile_ar/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.SPLASH: (context) => const SplashView(),
    Routes.SIGN_IN: (context) => const SignInView(),
    Routes.HOME: (context) => const HomeView(),
  };
}
