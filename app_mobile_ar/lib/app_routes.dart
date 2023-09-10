

import 'package:app_mobile_ar/pages/login_page.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    '/': (context) => const LoginPage()
  };
}