import 'package:emm_app/models/patient_model.dart';

import 'user_model.dart';

class Medical extends User {
  final String? title;
  final String? department;

  final List<Patient>? patients;

  const Medical({
    required super.id,
    required super.username,
    required super.type,
    super.name,
    super.lastnames,
    super.email,
    super.phone,
    super.gender,
    super.hospital,
    this.title,
    this.department,
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
      "title": title,
      "department": department,
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
      "title": title,
      "department": department,
    };
  }

  @override
  bool operator ==(Object other) => other is Medical && other.id == id;

  @override
  int get hashCode => id.hashCode;

}
