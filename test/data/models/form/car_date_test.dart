import 'package:flutter_test/flutter_test.dart';
import 'package:vehicles_app/data/models/form/car_date.dart';

void main() {
  late CarDate carDate;

  setUp(() {
    carDate = CarDate.pure();
  });

  group('Testing CarDate validation', () {
    test('Given empty string, then validation is invalid', () {
      expect(carDate.validator('  '), CarDateValidationError.invalid);
      expect(carDate.validator(''), CarDateValidationError.invalid);
    });

    test(
        'Given string containing any no-number character, then validation is invalid',
        () {
      expect(carDate.validator('209r/apr/10'), CarDateValidationError.invalid);
      expect(carDate.validator('date'), CarDateValidationError.invalid);
      expect(carDate.validator('1234/--/10'), CarDateValidationError.invalid);
    });

    test('Given invalid date string, then validation is invalid', () {
      expect(carDate.validator('2341/13/22'), CarDateValidationError.invalid);
      expect(carDate.validator('2000/09/42'), CarDateValidationError.invalid);
      expect(carDate.validator('2000/00/00'), CarDateValidationError.invalid);
    });

    test('Given correct date string, then validation is valid', () {
      expect(carDate.validator('2020/09/02'), null);
      expect(carDate.validator('2017/12/20'), null);
      expect(carDate.validator('1994/01/31'), null);
      expect(carDate.validator('2020/9/6'), null);
      expect(carDate.validator('1994/10/1'), null);
    });
  });
}
