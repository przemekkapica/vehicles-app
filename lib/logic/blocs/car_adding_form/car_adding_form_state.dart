import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:vehicles_app/data/models/form/car_form_models.dart';

class CarAddingFormState extends Equatable {
  const CarAddingFormState({
    this.brand = const CarBrand.pure(),
    this.model = const CarModel.pure(),
    this.date = const CarDate.pure(),
    this.registration = const CarRegistration.pure(),
    this.errorMessage = '',
    this.status = FormzStatus.pure,
  });

  final CarBrand brand;
  final CarModel model;
  final CarDate date;
  final CarRegistration registration;
  final String errorMessage;
  final FormzStatus status;

  CarAddingFormState copyWith({
    CarBrand? brand,
    CarModel? model,
    CarDate? date,
    CarRegistration? registration,
    String? errorMessage,
    FormzStatus? status,
  }) {
    return CarAddingFormState(
      brand: brand ?? this.brand,
      model: model ?? this.model,
      date: date ?? this.date,
      registration: registration ?? this.registration,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [brand, model, registration, date, errorMessage, status];
}
