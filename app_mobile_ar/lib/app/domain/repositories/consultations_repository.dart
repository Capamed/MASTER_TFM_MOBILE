import 'package:app_mobile_ar/app/domain/models/consultation.dart';
import '../either.dart';
import '../enums/enums.dart';

abstract class ConsultationsRepository {
  Future<Either<SignInFailure, List<Consultation>>> getDataConsultations(
      String identificationNumber);
  Future<Either<SignInFailure, int>> createNewRegister(
      dynamic newRegister);
  Future<Either<SignInFailure, String>> deleteConsultationById(
      int consultationId);
  Future<Either<SignInFailure, int>> updateConsultationById(
      int consultationId, dynamic updateConsultation);
}
