import 'package:flutter/material.dart';

class RegisterMedicationView extends StatefulWidget {
  const RegisterMedicationView({super.key, required this.identificationNumber});

  final String identificationNumber;

  @override
  State<RegisterMedicationView> createState() => _RegisterMedicationViewState();
}

class _RegisterMedicationViewState extends State<RegisterMedicationView> {
  @override
  void initState() {
    super.initState();
    _getDataDoctors();
    _getDataMedications();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.identificationNumber),
    );
  }

  _getDataDoctors() {}
  _getDataMedications() {}
}
