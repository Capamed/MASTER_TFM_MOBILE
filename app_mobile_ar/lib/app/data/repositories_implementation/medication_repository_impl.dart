
import 'package:app_mobile_ar/app/domain/either.dart';
import 'package:app_mobile_ar/app/domain/models/medication.dart';
import '../../domain/enums/enums.dart';
import '../../domain/repositories/medications_repository.dart';
import '../services/remote/medication_api.dart';


class MedicationRepositoryImpl implements MedicationsRepository {
  MedicationRepositoryImpl(this._medicationAPI);

  final MedicationAPI _medicationAPI;
  
  @override
  Future<Either<SignInFailure, List<Medication>>> getDataMedications() async {
    final response = await _medicationAPI.getDataMedication();
    return response.when((failure) {
      return Either.left(failure);
    }, (medications) {
      return Either.right(medications);
    });
  }


}
