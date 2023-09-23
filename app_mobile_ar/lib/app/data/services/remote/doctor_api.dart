import 'dart:convert';
import 'dart:io';

import 'package:app_mobile_ar/app/domain/either.dart';
import 'package:app_mobile_ar/app/domain/enums/enums.dart';
import 'package:app_mobile_ar/app/domain/models/doctor.dart';

import '../../http/http.dart';

class DoctorAPI {
  DoctorAPI(this._http);
  final Http _http;

  Future<Either<SignInFailure, List<Doctor>>> getDataDoctor() async {
    final result = await _http.request('doctors/',
        method: HttpMethod.get);
     
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
      return Either.right(value);
    });
  }
}
