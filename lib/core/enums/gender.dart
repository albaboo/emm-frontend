enum Gender {
  male('MALE'),
  female('FEMALE'),
  unknown('UNKNOWN');

  final String value;
  const Gender(this.value);

  static Gender fromString(String value) {
    return Gender.values.firstWhere(
          (e) => e.value == value,
      orElse: () => Gender.unknown,
    );
  }
}