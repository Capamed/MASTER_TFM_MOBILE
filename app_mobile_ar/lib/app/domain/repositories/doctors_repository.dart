

import 'package:app_mobile_ar/app/domain/models/doctor.dart';

import '../either.dart';
import '../enums/enums.dart';

abstract class DoctorsRepository {
    Future<Either<SignInFailure, List<Doctor>>> getDataDoctors();
}

