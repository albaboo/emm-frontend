abstract class User {
  final String id;
  final String name;
  final String lastnames;
  final String email;
  final String phone;
  final String password;
  final String gender;
  final String type;

  const User({
    required this.id,
    required this.name,
    required this.lastnames,
    required this.email,
    required this.phone,
    required this.password,
    required this.gender,
    required this.type,
  });

}
