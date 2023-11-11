abstract interface class IProfileEntity {
  IProfileEntity({required this.fullName, required this.age, required this.counter});

  final String fullName;
  final int age;
  final int counter;
}
