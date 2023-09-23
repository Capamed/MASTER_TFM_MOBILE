
import 'package:app_mobile_ar/app/domain/models/medication.dart';

import '../either.dart';
import '../enums/enums.dart';

abstract class MedicationsRepository {
  Future<Either<SignInFailure, List<Medication>>> getDataMedications();
}

