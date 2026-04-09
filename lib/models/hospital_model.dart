

import 'user_model.dart';
class Hospital extends User {
  final String address;

  const Hospital({
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
