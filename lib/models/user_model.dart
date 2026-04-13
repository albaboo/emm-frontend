import 'package:emm_app/models/hospital_model.dart';

import '../core/enums/user_types.dart';

abstract class User {
  final int id;
  final String username;
  final String? name;
  final String? lastnames;
  final String? email;
  final String? phone;
  final String? gender;
  final UserType type;
  final Hospital? hospital;

  const User({
    required this.id,
    required this.username,
    required this.type,
    this.name,
    this.lastnames,
    this.email,
    this.phone,
    this.gender,
    this.hospital,
  });
}
