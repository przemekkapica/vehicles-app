import 'package:flutter_test/flutter_test.dart';
import 'package:vehicles_app/data/models/form/car_brand.dart';

void main() {
  late CarBrand carBrand;

  setUp(() {
    carBrand = CarBrand.pure();
  });

  group('Testing CarBrand validation', () {
    test('Given empty string, then validation is invalid', () {
      expect(carBrand.validator('  '), CarBrandValidationError.invalid);
      expect(carBrand.validator(''), CarBrandValidationError.invalid);
    });

    test('Given string with any special character, then validation is invalid',
        () {
      expect(carBrand.validator('/owke.'), CarBrandValidationError.invalid);
      expect(carBrand.validator('po -sdf'), CarBrandValidationError.invalid);
      expect(carBrand.validator('_'), CarBrandValidationError.invalid);
    });

    test('Given alphanumeric string, then validation is valid', () {
      expect(carBrand.validator('word Word'), null);
      expect(carBrand.validator('wORd'), null);
      expect(carBrand.validator('Word 213'), null);
    });
  });
}
