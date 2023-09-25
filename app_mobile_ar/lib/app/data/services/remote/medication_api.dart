import 'dart:convert';
import 'dart:io';

import 'package:app_mobile_ar/app/domain/either.dart';
import 'package:app_mobile_ar/app/domain/enums/enums.dart';

import '../../../domain/models/medication.dart';
import '../../http/http.dart';

class MedicationAPI {
  MedicationAPI(this._http);
  final Http _http;

  Future<Either<SignInFailure, List<Medication>>> getDataMedication() async {
    final result = await _http.request('medications/', method: HttpMethod.get);

    return result.when((failure) {
      if (failure.statusCode != null) {
        switch (failure.statusCode!) {
          case 401:
            return Either.left(SignInFailure.unauthorized);
          case 404:
            return Either.left(SignInFailure.notFound);
          default:
            return Either.left(SignInFailure.unknown);
        }
      }
      if (failure.exception is NetworkException) {
        return Either.left(SignInFailure.unknown);
      }
      return Either.left(SignInFailure.unknown);
    }, (responseBody) {
      final value = jsonDecode(responseBody);
      final medications = value.map((json) => Medication.fromJson(json)).toList();
      final List<Medication> medicationList = List<Medication>.from(medications);
      return Either.right(medicationList);
    });
  }
}
