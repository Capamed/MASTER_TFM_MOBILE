import 'package:app_mobile_ar/app/data/http/http.dart';
import 'package:app_mobile_ar/app/data/repositories_implementation/consultation_repository_impl.dart';
import 'package:app_mobile_ar/app/data/repositories_implementation/doctor_repository_impl.dart';
import 'package:app_mobile_ar/app/data/repositories_implementation/medication_repository_impl.dart';
import 'package:app_mobile_ar/app/data/services/remote/authentication_api.dart';
import 'package:app_mobile_ar/app/data/services/remote/doctor_api.dart';
import 'package:app_mobile_ar/app/data/services/remote/medication_api.dart';
import 'package:app_mobile_ar/app/domain/repositories/consultations_repository.dart';
import 'package:app_mobile_ar/app/domain/repositories/medications_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/services/remote/consultation_api.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/doctors_repository.dart';
import 'app/my_app.dart';
import 'package:http/http.dart' as http;

const String enviroment = 'http://192.168.100.9:3000/api/';
const String local = 'http://localhost:3000/api/';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<AuthenticationRepository>(
        create: (_) => AuthenticationRepositoryImpl(
          AuthenticationAPI(
            Http(
              baseUrl: local,
              client: http.Client(),
            ),
          ),
        ),
      ),
      Provider<DoctorsRepository>(
        create: (_) => DoctorRepositoryImpl(
          DoctorAPI(
            Http(
              baseUrl: local,
              client: http.Client(),
            ),
          ),
        ),
      ),
      Provider<MedicationsRepository>(
        create: (_) => MedicationRepositoryImpl(
          MedicationAPI(
            Http(
              baseUrl: local,
              client: http.Client(),
            ),
          ),
        ),
      ),
      Provider<ConsultationsRepository>(
        create: (_) => ConsultationRepositoryImpl(
          ConsultationAPI(
            Http(
              baseUrl: local,
              client: http.Client(),
            ),
          ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}