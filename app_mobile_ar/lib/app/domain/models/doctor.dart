class Doctor {
  final String identificationNumber;
  final String nameDoctor;
  final String photo;

  Doctor({
    required this.identificationNumber,
    required this.nameDoctor,
    required this.photo,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      identificationNumber: json['identificationNumber'] as String,
      nameDoctor: json['nameDoctor'] as String,
      photo: json['photo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identificationNumber': identificationNumber,
      'nameDoctor': nameDoctor,
      'photo': photo,
    };
  }
}
