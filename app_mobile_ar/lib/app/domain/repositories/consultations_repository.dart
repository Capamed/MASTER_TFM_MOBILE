
import 'package:app_mobile_ar/app/domain/models/consultation.dart';
import '../either.dart';
import '../enums/enums.dart';

abstract class ConsultationsRepository {
  Future<Either<SignInFailure, List<Consultation>>> getDataConsultations(String identificationNumber);
}

