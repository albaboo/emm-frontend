

import 'user_model.dart';
class Admin extends User {
  final String address;

  const Admin({
    required super.id,
    required super.name,
    required super.lastnames,
    required super.email,
    required super.phone,
    required super.password,
    required super.gender,
    required this.address,
  });

  @override
  String get role => 'Hospital';
}
