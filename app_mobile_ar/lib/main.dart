import 'package:app_mobile_ar/app/data/http/http.dart';
import 'package:app_mobile_ar/app/data/services/remote/authentication_api.dart';
import 'package:flutter/material.dart';

import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/my_app.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(Injector(
      child: MyApp(),
      authenticationRepository: AuthenticationRepositoryImpl(
        AuthenticationAPI(Http(baseUrl: 'http://localhost:3000/api/',client: http.Client()))
      )));
}

class Injector extends InheritedWidget {
  const Injector(
      {super.key,
      required super.child,
      required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }

  @override
  bool updateShouldNotify(Injector oldWidget) {
    return false;
  }
}
