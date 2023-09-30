import 'dart:convert';
import 'dart:io';

import 'package:app_mobile_ar/app/domain/either.dart';
import 'package:app_mobile_ar/app/domain/enums/enums.dart';
import 'package:app_mobile_ar/app/domain/models/consultation.dart';
import '../../http/http.dart';

class ConsultationAPI {
  ConsultationAPI(this._http);
  final Http _http;

  Future<Either<SignInFailure, List<Consultation>>> getDataConsultationById(
      String identificactionNumber) async {
    final result = await _http.request('consultations/$identificactionNumber',
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
      final consultations =
          value.map((json) => Consultation.fromJson(json)).toList();
      final List<Consultation> consultationList =
          List<Consultation>.from(consultations);
      return Either.right(consultationList);
    });
  }

  Future<Either<SignInFailure, int>> createNewRegister(
      dynamic register) async {
    final result = await _http.request('consultations',
        method: HttpMethod.post, body: register);
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

  Future<Either<SignInFailure, String>> deleteConsultationById(
      int consultationId) async {
    final result = await _http.request('consultations/$consultationId',
        method: HttpMethod.delete);
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

  Future<Either<SignInFailure, int>> updateConsultationById(
      int consultationId, dynamic updateConsultation) async {
    final result = await _http.request('consultations/$consultationId',
        method: HttpMethod.patch, body: updateConsultation);
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
      return Either.right(value['consultationId']);
    });
  }
}
