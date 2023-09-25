class Medication {
  final int medicationId;
  final String nameMedication;
  final String amount;
  final String photo;
  final String idVuforia;

  Medication(
      {required this.medicationId,
      required this.nameMedication,
      required this.amount,
      required this.photo,
      required this.idVuforia});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
        medicationId: json['medicationId'] as int,
        nameMedication: json['nameMedication'] as String,
        amount: json['amount'] as String,
        photo: json['photo'] as String,
        idVuforia: json['idVuforia'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'medicationId': medicationId,
      'nameMedication': nameMedication,
      'amount': amount,
      'photo': photo,
      'idVuforia': idVuforia
    };
  }
}
