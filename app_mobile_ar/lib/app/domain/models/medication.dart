class Medication {
  final String medicationId;
  final String nameMedication;
  final String amount;
  final String photo;

  Medication(
      {required this.medicationId,
      required this.nameMedication,
      required this.amount,
      required this.photo});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
        medicationId: json['medicationId'] as String,
        nameMedication: json['nameMedication'] as String,
        amount: json['amount'] as String,
        photo: json['photo'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'medicationId': medicationId,
      'nameMedication': nameMedication,
      'amount': amount,
      'photo': photo
    };
  }
}
