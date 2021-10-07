import 'package:formz/formz.dart';

enum CarRegistrationValidationError { invalid }

class CarRegistration
    extends FormzInput<String, CarRegistrationValidationError> {
  const CarRegistration.pure([String value = '']) : super.pure(value);
  const CarRegistration.dirty([String value = '']) : super.dirty(value);

  static final _casualRegistrationRegex = RegExp(r'^[A-Z]{2,3}\s?[A-Z0-9]{5}$',
      caseSensitive: false); // ex. SK 3829W or WWEH2I90

  static final _orderedRegistrationRegex = RegExp(
      r'^[A-Z]{1}[0-9]{1}\s?[A-Z0-9]{4,5}$',
      caseSensitive: false); // ex. E0 BOSS

  static final _carRegistrationRegex = RegExp(
      r'^[A-Za-z0-9 ]+$'); // allows letters, numbers and whitespaces between words

  @override
  CarRegistrationValidationError? validator(String? value) {
    value = value!.trim();
    return ((_casualRegistrationRegex.hasMatch(value) ||
                _orderedRegistrationRegex.hasMatch(value)) &&
            _carRegistrationRegex.hasMatch(value))
        ? null
        : CarRegistrationValidationError.invalid;
  }
}
