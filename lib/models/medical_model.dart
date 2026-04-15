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
}
