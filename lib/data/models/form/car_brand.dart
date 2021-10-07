import 'package:formz/formz.dart';

enum CarBrandValidationError { invalid }

class CarBrand extends FormzInput<String, CarBrandValidationError> {
  const CarBrand.pure([String value = '']) : super.pure(value);
  const CarBrand.dirty([String value = '']) : super.dirty(value);

  static final _carBrandRegex = RegExp(
      r'^[A-Za-z0-9 ]+$'); // allows letters, numbers and whitespaces between words

  @override
  CarBrandValidationError? validator(String? value) {
    value = value!.trim();
    return _carBrandRegex.hasMatch(value)
        ? null
        : CarBrandValidationError.invalid;
  }
}
