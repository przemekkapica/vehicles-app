import 'package:formz/formz.dart';

enum CarModelValidationError { invalid }

class CarModel extends FormzInput<String, CarModelValidationError> {
  const CarModel.pure([String value = '']) : super.pure(value);
  const CarModel.dirty([String value = '']) : super.dirty(value);

  static final _carModelRegex = RegExp(
      r'^[A-Za-z0-9 ]+$'); // allows letters, numbers and whitespaces between words

  @override
  CarModelValidationError? validator(String? value) {
    value = value!.trim();
    return _carModelRegex.hasMatch(value)
        ? null
        : CarModelValidationError.invalid;
  }
}
