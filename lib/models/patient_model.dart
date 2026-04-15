import 'carer_model.dart';
import 'medical_model.dart';
import 'user_model.dart';

class Patient extends User {
  final DateTime? birthdate;
  final DateTime? lastVisit;
  final String? grade;

  final Medical? medical;
  final List<Carer>? carers;

  const Patient({
    required super.id,
    required super.username,
    required super.type,
    super.name,
    super.lastnames,
    super.email,
    super.phone,
    super.gender,
    super.hospital,
    this.birthdate,
    this.lastVisit,
    this.grade,
    this.medical,
    this.carers,
  });
}
