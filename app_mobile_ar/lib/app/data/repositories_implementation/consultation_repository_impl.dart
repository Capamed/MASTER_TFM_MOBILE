
import 'package:app_mobile_ar/app/domain/either.dart';

import '../../domain/enums/enums.dart';
import '../../domain/models/consultation.dart';
import '../../domain/repositories/consultations_repository.dart';
import '../services/remote/consultation_api.dart';

class ConsultationRepositoryImpl implements ConsultationsRepository {
  ConsultationRepositoryImpl(this._consultationAPI);

  final ConsultationAPI _consultationAPI;
  
  @override
  Future<Either<SignInFailure, List<Consultation>>> getDataConsultations(String identificationNumber) async {
    return _consultationAPI.getDataConsultationById(identificationNumber);
  }


}
