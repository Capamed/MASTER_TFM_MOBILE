import 'package:app_mobile_ar/app/domain/either.dart';

import '../enums/enums.dart';
import '../models/user.dart';

abstract class AuthenticationRepository {
  Future<User> getUserData();
  Future<Either<SignInFailure, bool>> signIn(String username, String password);
}

