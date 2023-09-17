import 'package:app_mobile_ar/app/presentation/modules/home/views/home_view.dart';
import 'package:app_mobile_ar/app/presentation/modules/sign_in/views/sign_in_view.dart';
import 'package:app_mobile_ar/app/presentation/modules/splash/views/splash_view.dart';
import 'package:app_mobile_ar/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

T getArguments<T>(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as T;
}

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.SPLASH: (context) => const SplashView(),
    Routes.SIGN_IN: (context) => const SignInView(),
    Routes.HOME: (context){
      final identificationNumber = getArguments<String>(context);
          return HomeView(
            identificationNumber: identificationNumber,
          );
        },
  };
}
