abstract class User {
  final String id;
  final String name;
  final String lastnames;
  final String email;
  final String phone;
  final String password;
  final String gender ;


  const User({
    required this.id,
    required this.name,
    required this.lastnames,
    required this.email ,
    required this.phone ,
    required this.password,
    required this.gender,

  });

  String get role;
}


