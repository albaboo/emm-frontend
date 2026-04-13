import '../core/enums/user_types.dart';
import '../models/admin_model.dart';
import '../models/carer_model.dart';
import '../models/hospital_model.dart';
import '../models/medical_model.dart';
import '../models/patient_model.dart';
import '../models/user_model.dart';

class UserFactory {
  static User fromJson(Map<String, dynamic> json) {
    final type = UserType.fromString(json['type']);

    switch (type) {
      case UserType.patient:
        return Patient(
          id: json['id'] ?? 0,
          username: json['username'],
          type: type,
          name: json['name'],
          lastnames: json['lastnames'],
          email: json['email'],
          phone: json['phone'],
          gender: json['gender'],
          hospital: _parseHospital(json['hospital']),
          birthdate: json['birthdate'] != null
              ? DateTime.tryParse(json['birthdate'])
              : null,
          lastVisit: json['lastVisit'] != null
              ? DateTime.tryParse(json['lastVisit'])
              : null,
          grade: json['grade'],

          medical: json['medical'] != null
              ? fromJson(json['medical']) as Medical
              : null,

          carers: (json['carers'] as List?)
              ?.map((e) => fromJson(e) as Carer)
              .toList(),
        );

      case UserType.medical:
        return Medical(
          id: json['id'] ?? 0,
          username: json['username'],
          type: type,
          name: json['name'],
          lastnames: json['lastnames'],
          email: json['email'],
          phone: json['phone'],
          gender: json['gender'],
          hospital: _parseHospital(json['hospital']),
          title: json['title'],
          department: json['department'],

          patients: (json['patients'] as List?)
              ?.map((e) => fromJson(e) as Patient)
              .toList(),
        );

      case UserType.carer:
        return Carer(
          id: json['id'] ?? 0,
          username: json['username'],
          type: type,
          name: json['name'],
          lastnames: json['lastnames'],
          email: json['email'],
          phone: json['phone'],
          gender: json['gender'],
          hospital: _parseHospital(json['hospital']),
          professional: json['professional'] ?? false,

          patients: (json['patients'] as List?)
              ?.map((e) => fromJson(e) as Patient)
              .toList(),
        );

      case UserType.admin:
        return Admin(
          id: json['id'] ?? 0,
          username: json['username'],
          type: type,
          name: json['name'],
          lastnames: json['lastnames'],
          email: json['email'],
          phone: json['phone'],
          gender: json['gender'],
          hospital: _parseHospital(json['hospital']),
        );
    }
  }
}

Hospital? _parseHospital(Map<String, dynamic>? json) {
  if (json == null) return null;

  return Hospital(
    id: json['id'] ?? 0,
    name: json['name'],
    address: json['address'],
    phone: json['phone'],
    email: json['email'],

    users: (json['users'] as List?)
        ?.map((e) => UserFactory.fromJson(e))
        .toList(),
  );
}
