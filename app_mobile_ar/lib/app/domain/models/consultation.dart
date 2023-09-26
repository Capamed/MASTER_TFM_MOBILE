import 'package:app_mobile_ar/app/domain/models/doctor.dart';
import 'package:app_mobile_ar/app/domain/models/medication.dart';
import 'package:app_mobile_ar/app/domain/models/user.dart';

class Consultation {
  final int consultationId;
  final String schedule;
  final String observation;
  final String symbol;
  final String status;
  final User user;
  final String identificationNumberUser;
  final Doctor doctor;
  final Medication medication;

  Consultation(
      {required this.consultationId,
      required this.schedule,
      required this.observation,
      required this.symbol,
      required this.status,
      required this.user,
      required this.identificationNumberUser,
      required this.doctor,
      required this.medication});

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
        consultationId: json['consultationId'] as int,
        schedule: json['schedule'] as String,
        observation: json['observation'] as String,
        symbol: json['symbol'] as String,
        status: json['status'] as String,
        user: json['user'] as User,
        identificationNumberUser: json['identificationNumberUser'] as String, 
        doctor: json['doctor'] as Doctor, 
        medication: json['medication'] as Medication);
  }

  Map<String, dynamic> toJson() {
    return {
      'consultationId': consultationId,
      'schedule': schedule,
      'observation': observation,
      'symbol': symbol,
      'status': status,
      'user': user,
      'identificationNumberUser': identificationNumberUser,
      'doctor': doctor,
      'medication': medication
    };
  }
}
