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
    };
  }
}
