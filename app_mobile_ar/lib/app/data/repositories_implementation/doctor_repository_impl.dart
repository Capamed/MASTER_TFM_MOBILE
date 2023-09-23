import 'package:app_mobile_ar/app/data/services/remote/doctor_api.dart';
import 'package:app_mobile_ar/app/domain/either.dart';
import 'package:app_mobile_ar/app/domain/models/doctor.dart';
import 'package:app_mobile_ar/app/domain/repositories/doctors_repository.dart';

import '../../domain/enums/enums.dart';

class DoctorRepositoryImpl implements DoctorsRepository {
  DoctorRepositoryImpl(this._doctorAPI);

  final DoctorAPI _doctorAPI;

  @override
  Future<Either<SignInFailure, List<Doctor>>> getDataDoctors() async {
    return _doctorAPI.getDataDoctor();
  }
}
