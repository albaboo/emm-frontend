import 'package:emm_app/models/patient_model.dart';

import 'user_model.dart';

class Carer extends User {
  final bool professional;

  final List<Patient>? patients;

  const Carer({
    required super.id,
    required super.username,
    required super.type,
    super.name,
    super.lastnames,
    super.email,
    super.phone,
    super.gender,
    super.hospital,
    this.professional = false,
    this.patients,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "name": name,
      "lastnames": lastnames,
      "email": email,
      "phone": phone,
      "gender": gender?.name,
      "type": type.value,
      "hospital": hospital?.toJsonBase(),
      "professional": professional,
      "patients": patients?.map((p) => p.toJsonBase()).toList(),
    };
  }

  @override
  Map<String, dynamic> toJsonBase() {
    return {
      "id": id,
      "username": username,
      "name": name,
      "lastnames": lastnames,
      "email": email,
      "phone": phone,
      "gender": gender?.name,
      "type": type.value,
      "professional": professional,
    };
  }

  @override
  bool operator ==(Object other) => other is Carer && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
