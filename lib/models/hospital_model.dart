import 'package:emm_app/models/user_model.dart';

class Hospital {
  final int id;
  final String name;
  final String? address;
  final String? phone;
  final String? email;

  final List<User>? users;

  const Hospital({
    required this.id,
    required this.name,
    this.address,
    this.phone,
    this.email,
    this.users,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "phone": phone,
      "email": email,
      "users": users?.map((u) => u.toJsonBase()).toList(),
    };
  }

  Map<String, dynamic> toJsonBase() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "phone": phone,
      "email": email,
    };
  }
}
