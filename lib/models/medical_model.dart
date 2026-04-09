
import 'user_model.dart';
class Medical extends User {
  final String title;
  final String department;

  const Medical({
    required super.id,
    required super.name,
    required super.lastnames,
    required super.email,
    required super.phone,
    required super.password,
    required super.gender,
    required this.title,
    required this.department,
  });

  @override
  String get role => 'Medical';
}