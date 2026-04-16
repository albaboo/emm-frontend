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
      "birthdate": birthdate?.toIso8601String(),
      "lastVisit": lastVisit?.toIso8601String(),
      "grade": grade,
      "medical": medical?.toJsonBase(),
      "carers": carers?.map((c) => c.toJsonBase()).toList(),
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
      "birthdate": birthdate?.toIso8601String(),
      "lastVisit": lastVisit?.toIso8601String(),
      "grade": grade,
    };

  }

}
