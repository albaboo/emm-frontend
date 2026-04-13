import 'user_model.dart';

class Admin extends User {
  const Admin({
    required super.id,
    required super.username,
    required super.type,
    super.name,
    super.lastnames,
    super.email,
    super.phone,
    super.gender,
    super.hospital,
  });
}
