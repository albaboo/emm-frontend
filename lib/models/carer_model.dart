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
}
