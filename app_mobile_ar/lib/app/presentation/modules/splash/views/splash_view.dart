import 'package:app_mobile_ar/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // Para comprobar si tenemos internet pero eso no lo vamos a implementar
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      print("Tarea programada después de 3 segundos");
      Navigator.pushReplacementNamed(context, Routes.SIGN_IN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 70,
          height: 70,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
