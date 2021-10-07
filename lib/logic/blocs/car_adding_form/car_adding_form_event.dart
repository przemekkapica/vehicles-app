import 'package:equatable/equatable.dart';
import 'package:vehicles_app/data/models/car.dart';
import 'package:vehicles_app/data/models/dto/car_dto.dart';

abstract class CarAddingFormEvent extends Equatable {
  const CarAddingFormEvent();

  @override
  List<Object> get props => [];
}

// --------------- car brand events ---------------
class CarBrandChanged extends CarAddingFormEvent {
  const CarBrandChanged({required this.brand});

  final String brand;

  @override
  List<Object> get props => [brand];
}

class CarBrandUnfocused extends CarAddingFormEvent {}

// --------------- car model events ---------------
class CarModelChanged extends CarAddingFormEvent {
  const CarModelChanged({required this.model});

  final String model;

  @override
  List<Object> get props => [model];
}

class CarModelUnfocused extends CarAddingFormEvent {}

// --------------- car registration events ---------------
class CarRegistrationChanged extends CarAddingFormEvent {
  const CarRegistrationChanged({required this.registration});

  final String registration;

  @override
  List<Object> get props => [registration];
}

class CarRegistrationUnfocused extends CarAddingFormEvent {}

// --------------- car date events ---------------
class CarDateChanged extends CarAddingFormEvent {
  const CarDateChanged({required this.date});

  final String date;

  @override
  List<Object> get props => [date];
}

class CarDateUnfocused extends CarAddingFormEvent {}

class FormSubmitted extends CarAddingFormEvent {
  const FormSubmitted({required this.car});

  final CarDTO car;

  @override
  List<Object> get props => [car];
}
