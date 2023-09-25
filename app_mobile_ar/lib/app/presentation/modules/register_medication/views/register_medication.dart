import 'package:app_mobile_ar/app/domain/enums/enums.dart';
import 'package:app_mobile_ar/app/presentation/modules/register_medication/widgets/register_medication_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile_ar/main.dart';

import '../../../routes/routes.dart';

class RegisterMedicationView extends StatefulWidget {
  const RegisterMedicationView({super.key, required this.identificationNumber});

  final String identificationNumber;

  @override
  State<RegisterMedicationView> createState() => _RegisterMedicationViewState();
}

class _RegisterMedicationViewState extends State<RegisterMedicationView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'Register medication:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
          ),
          RegisterMedicationWidget(),
        ],
      )),
    );
  }
}
