import 'package:app_mobile_ar/app/presentation/modules/home/views/home_view.dart';
import 'package:app_mobile_ar/app/presentation/modules/register_medication/views/register_medication.dart';
import 'package:app_mobile_ar/app/presentation/modules/show_register/views/show_register.dart';
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
    Routes.HOME: (context) {
      final identificationNumber = getArguments<String>(context);//getArguments<String>(context);
      return HomeView(
        identificationNumber: identificationNumber,
      );
    },
    Routes.REGISTER_MEDICATION: (context) {
      final identificationNumber = getArguments<String>(context);//getArguments<String>(context);
      return RegisterMedicationView(
        identificationNumber: identificationNumber,
      );
    },
      Routes.SHOW_REGISTERS: (context) {
      final identificationNumber = getArguments<String>(context);//getArguments<String>(context);
      return ShowRegistersView(
        identificationNumber: identificationNumber,
      );
    },
  };
}
