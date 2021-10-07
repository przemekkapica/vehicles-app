import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:vehicles_app/data/models/form/car_brand.dart';
import 'package:vehicles_app/data/models/form/car_date.dart';
import 'package:vehicles_app/data/models/form/car_model.dart';
import 'package:vehicles_app/data/models/form/car_registration.dart';
import 'package:vehicles_app/data/services/vehicles_service.dart';
import 'package:vehicles_app/logic/blocs/car_adding_form/bloc.dart';

class CarAddingFormBloc extends Bloc<CarAddingFormEvent, CarAddingFormState> {
  CarAddingFormBloc({required this.vehiclesService})
      : super(const CarAddingFormState());

  final VehiclesService vehiclesService;

  @override
  void onTransition(
      Transition<CarAddingFormEvent, CarAddingFormState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<CarAddingFormState> mapEventToState(CarAddingFormEvent event) async* {
    if (event is CarBrandChanged) {
      final brand = CarBrand.dirty(event.brand);
      yield state.copyWith(
        brand: brand.valid ? brand : CarBrand.pure(event.brand),
        status: Formz.validate(
            [brand, state.model, state.registration, state.date]),
      );
    } else if (event is CarBrandUnfocused) {
      final brand = CarBrand.dirty(state.brand.value);
      yield state.copyWith(
        brand: brand,
        status: Formz.validate(
            [brand, state.model, state.registration, state.date]),
      );
    } else if (event is CarModelChanged) {
      final model = CarModel.dirty(event.model);
      yield state.copyWith(
        model: model.valid ? model : CarModel.pure(event.model),
        status: Formz.validate(
            [state.brand, model, state.registration, state.date]),
      );
    } else if (event is CarModelUnfocused) {
      final model = CarModel.dirty(state.model.value);
      yield state.copyWith(
        model: model,
        status: Formz.validate(
            [state.brand, model, state.registration, state.date]),
      );
    } else if (event is CarRegistrationChanged) {
      final registration = CarRegistration.dirty(event.registration);
      yield state.copyWith(
        registration: registration.valid
            ? registration
            : CarRegistration.pure(event.registration),
        status: Formz.validate(
            [state.brand, state.model, registration, state.date]),
      );
    } else if (event is CarRegistrationUnfocused) {
      final registration = CarRegistration.dirty(state.registration.value);
      yield state.copyWith(
        registration: registration,
        status: Formz.validate(
            [state.brand, state.model, registration, state.date]),
      );
    } // Date events
    else if (event is CarDateChanged) {
      final date = CarDate.dirty(event.date);
      yield state.copyWith(
        date: date.valid ? date : CarDate.pure(event.date),
        status: Formz.validate(
            [state.brand, state.model, state.registration, date]),
      );
    } else if (event is CarDateUnfocused) {
      final date = CarDate.dirty(state.date.value);
      yield state.copyWith(
        date: date,
        status: Formz.validate(
            [state.brand, state.model, state.registration, date]),
      );
    } else if (event is FormSubmitted) {
      final brand = CarBrand.dirty(state.brand.value);
      final model = CarModel.dirty(state.model.value);
      final registration = CarRegistration.dirty(state.registration.value);
      final date = CarDate.dirty(state.date.value);

      yield state.copyWith(
        brand: brand,
        model: model,
        registration: registration,
        date: date,
        status: Formz.validate([brand, model, registration, date]),
      );

      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        try {
          await vehiclesService.addCar(event.car);
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } catch (err) {
          yield state.copyWith(
            errorMessage: err.toString(),
            status: FormzStatus.submissionFailure,
          );
        }
      }
    }
  }
}
