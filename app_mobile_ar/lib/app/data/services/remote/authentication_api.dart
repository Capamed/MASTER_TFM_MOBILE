import 'dart:convert';
import 'dart:io';

import 'package:app_mobile_ar/app/domain/either.dart';
import 'package:app_mobile_ar/app/domain/enums/enums.dart';

import '../../http/http.dart';

class AuthenticationAPI {
  AuthenticationAPI(this._http);
  final Http _http;

  Future<Either<SignInFailure, bool>> authenticationUser(
      {required String username, required String password}) async {
    final result = await _http.request('users/validateUser',
        method: HttpMethod.post,
        body: {'username': username, 'password': password});
     
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
      final value =jsonDecode(responseBody);
      if (value['user'] != null) {
        return Either.right(true);
      }else{
        return Either.left(SignInFailure.notFound);
      }
    });
  }
}
