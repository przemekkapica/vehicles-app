import 'package:flutter_test/flutter_test.dart';
import 'package:vehicles_app/data/models/form/car_registration.dart';

void main() {
  late CarRegistration carRegistration;

  setUp(() {
    carRegistration = CarRegistration.pure();
  });

  group('Testing CarRegistration validation', () {
    test('Given empty string, then validation is invalid', () {
      expect(carRegistration.validator('  '),
          CarRegistrationValidationError.invalid);
      expect(carRegistration.validator(''),
          CarRegistrationValidationError.invalid);
    });

    test('Given string with any special character, then validation is invalid',
        () {
      expect(carRegistration.validator('/owke.'),
          CarRegistrationValidationError.invalid);
      expect(carRegistration.validator('po -sdf'),
          CarRegistrationValidationError.invalid);
      expect(carRegistration.validator('_'),
          CarRegistrationValidationError.invalid);
    });

    test('Given invalid registraion number, then validation is invalid', () {
      expect(carRegistration.validator('DF KD920S'),
          CarRegistrationValidationError.invalid);
      expect(carRegistration.validator('WA 920S'),
          CarRegistrationValidationError.invalid);
      expect(carRegistration.validator('2D DJ029J'),
          CarRegistrationValidationError.invalid);
      expect(carRegistration.validator('cowddd023'),
          CarRegistrationValidationError.invalid);
    });

    test('Given proper registraion number string, then validation is valid',
        () {
      expect(carRegistration.validator('sk 1839h'), null);
      expect(carRegistration.validator('WEI9002'), null);
      expect(carRegistration.validator('KRA 90HBD'), null);
    });
  });
}
