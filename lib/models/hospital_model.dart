import 'package:emm_app/models/user_model.dart';

class Hospital {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String email;

  final List<User>? users;

  const Hospital({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    this.users,
  });
}
