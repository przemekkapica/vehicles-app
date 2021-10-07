import 'package:flutter_test/flutter_test.dart';
import 'package:vehicles_app/data/models/person.dart';

void main() {
  late Person person;

  setUp(() {
    person = Person(
      id: 'id',
      firstName: 'firstName',
      lastName: 'lastName',
      sex: 'sex',
      birthDate: 'birthDate',
    );
  });

  group('Testing Person model class ', () {
    test('Check runtime types', () {
      expect(person.id.runtimeType, String);
      expect(person.firstName.runtimeType, String);
      expect(person.lastName.runtimeType, String);
      expect(person.sex.runtimeType, String);
      expect(person.birthDate.runtimeType, String);
    });

    test('Test Person.fromJson constructor', () {
      Map<String, dynamic> personJson = {
        "_id": "5e5e3d7fc0ea272d00000820",
        "first_name": "Libby",
        "last_name": "Predovic",
        "birth_date": "2014-02-12T00:00:00.000Z",
        "sex": "M",
        "_mock": true
      };

      Person personFromJson = Person.fromJson(personJson);
      expect(personFromJson.runtimeType, Person);
    });
  });
}
