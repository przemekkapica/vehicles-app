import 'package:flutter_test/flutter_test.dart';
import 'package:vehicles_app/data/models/form/car_model.dart';

void main() {
  late CarModel carModel;

  setUp(() {
    carModel = CarModel.pure();
  });

  group('Testing CarModel validation', () {
    test('Given empty string, then validation is invalid', () {
      expect(carModel.validator('  '), CarModelValidationError.invalid);
      expect(carModel.validator(''), CarModelValidationError.invalid);
    });

    test('Given string with any special character, then validation is invalid',
        () {
      expect(carModel.validator('/owke.'), CarModelValidationError.invalid);
      expect(carModel.validator('po -sdf'), CarModelValidationError.invalid);
      expect(carModel.validator('_'), CarModelValidationError.invalid);
    });

    test('Given alphanumeric string, then validation is valid', () {
      expect(carModel.validator('word Word'), null);
      expect(carModel.validator('wORd'), null);
      expect(carModel.validator('Word 213'), null);
    });
  });
}
