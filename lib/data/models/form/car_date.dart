import 'package:formz/formz.dart';

enum CarDateValidationError { invalid }

class CarDate extends FormzInput<String, CarDateValidationError> {
  const CarDate.pure([String value = '']) : super.pure(value);
  const CarDate.dirty([String value = '']) : super.dirty(value);

  static final _carDateRegex = RegExp(
      r'^\d{4}\/(0?[1-9]|1[012])\/(0?[1-9]|[12][0-9]|3[01])$'); // yyyy-mm-dd or yyyy-m-d

  @override
  CarDateValidationError? validator(String? value) {
    value = value!.trim();
    return _carDateRegex.hasMatch(value)
        ? null
        : CarDateValidationError.invalid;
  }
}
