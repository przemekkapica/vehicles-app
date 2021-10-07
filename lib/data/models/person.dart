import 'package:equatable/equatable.dart';

class Person {
  final String id;
  final String firstName;
  final String lastName;
  final String birthDate;
  final String sex;

  Person(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      required this.sex});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        id: json['_id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        birthDate: json['birth_date'].toString().substring(0, 10),
        sex: json['sex']);
  }

  @override
  String toString() => 'Person with id: $id, $firstName $lastName';
}
