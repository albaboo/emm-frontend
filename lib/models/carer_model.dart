import 'user_model.dart';

class Carer extends User {
  const Carer({
    required super.id,
    required super.name,
    required super.lastnames,
    required super.email,
    required super.phone,
    required super.password,
    required super.gender,
  });

  @override
  String get role => 'Carer';
}
