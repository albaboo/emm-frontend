enum UserType {
  patient('PATIENT'),
  medical('MEDICAL'),
  admin('ADMIN'),
  carer('CARER');

  final String value;
  const UserType(this.value);

  static UserType fromString(String value) {
    return UserType.values.firstWhere(
          (e) => e.value == value,
      orElse: () => throw Exception('Unknown UserType: $value'),
    );
  }
}