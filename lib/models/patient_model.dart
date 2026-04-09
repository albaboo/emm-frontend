
import 'user_model.dart';
class Patient extends User {
  final DateTime birthdate;
  final String grade;

  const Patient({
    required super.id,
    required super.name,
    required super.lastnames,
    required super.email,
    required super.phone,
    required super.password,
    required super.gender,
    required this.birthdate,
    required this.grade,
  });

  @override
  String get role => 'Patient';
}