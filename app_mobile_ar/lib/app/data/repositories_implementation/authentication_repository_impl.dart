import 'package:app_mobile_ar/app/data/services/remote/authentication_api.dart';
import 'package:app_mobile_ar/app/domain/either.dart';
import 'package:app_mobile_ar/app/domain/models/user.dart';

import '../../domain/enums/enums.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this._authenticationAPI);

  final AuthenticationAPI _authenticationAPI;

  @override
  Future<User> getUserData() {
    return Future.value(User());
  }

  @override
  Future<Either<SignInFailure, bool>> signIn(
      String username, String password) async {
    final response = await _authenticationAPI.authenticationUser(
        username: username, password: password);
    return response.when((failure) {
      return Either.left(failure);
    }, (valueBool) {
      return Either.right(valueBool);
    });
  }
}
