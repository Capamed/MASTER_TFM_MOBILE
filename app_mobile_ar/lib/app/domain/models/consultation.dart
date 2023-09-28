import 'package:app_mobile_ar/app/domain/models/doctor.dart';
import 'package:app_mobile_ar/app/domain/models/medication.dart';

class Consultation {
  final int consultationId;
  final int schedule;
  final String observation;
  final String symbol;
  final String status;
  final String identificationNumberUser;
  final Doctor doctor;
  final Medication medication;

  Consultation(
      {required this.consultationId,
      required this.schedule,
      required this.observation,
      required this.symbol,
      required this.status,
      required this.identificationNumberUser,
      required this.doctor,
      required this.medication});

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
        consultationId: json['consultationId'] as int,
        schedule: json['schedule'] as int,
        observation: json['observation'] as String,
        symbol: json['symbol'] as String,
        status: json['status'] as String,
        identificationNumberUser: json['identificationNumberUser'] as String, 
        doctor: Doctor.fromJson(json['doctor']), 
        medication: Medication.fromJson(json['medication']));
  }

  Map<String, dynamic> toJson() {
    return {
      'consultationId': consultationId,
      'schedule': schedule,
      'observation': observation,
      'symbol': symbol,
      'status': status,
      'identificationNumberUser': identificationNumberUser,
      'doctor': doctor,
      'medication': medication
    };
  }
}
