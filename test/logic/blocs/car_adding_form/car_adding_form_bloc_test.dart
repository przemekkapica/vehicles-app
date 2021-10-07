import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:vehicles_app/data/models/dto/car_dto.dart';
import 'package:vehicles_app/data/models/form/car_form_models.dart';
import 'package:vehicles_app/data/services/mock/vehicles_service.mocks.dart';
import 'package:vehicles_app/logic/blocs/car_adding_form/bloc.dart';
import 'package:vehicles_app/logic/blocs/car_adding_form/car_adding_form_bloc.dart';

class MockCarAddingFormBloc
    extends MockBloc<CarAddingFormEvent, CarAddingFormState>
    implements CarAddingFormBloc {}

void main() {
  late CarAddingFormBloc carAddingFormBloc;
  late MockVehiclesService mockVehiclesService;

  setUp(() {
    mockVehiclesService = MockVehiclesService();
    carAddingFormBloc = CarAddingFormBloc(vehiclesService: mockVehiclesService);
  });

  tearDown(() {
    carAddingFormBloc.close();
  });

  test('Initial formz status should be FormzStatus.pure', () {
    expect(carAddingFormBloc.state.status, FormzStatus.pure);
  });

  test('Check bloc state types', () {
    expect(carAddingFormBloc.state.brand.runtimeType, CarBrand);
    expect(carAddingFormBloc.state.brand, CarBrand.pure());
    expect(carAddingFormBloc.state.model.runtimeType, CarModel);
    expect(carAddingFormBloc.state.model, CarModel.pure());
    expect(carAddingFormBloc.state.registration.runtimeType, CarRegistration);
    expect(carAddingFormBloc.state.registration, CarRegistration.pure());
    expect(carAddingFormBloc.state.date.runtimeType, CarDate);
    expect(carAddingFormBloc.state.date, CarDate.pure());
    expect(carAddingFormBloc.state.errorMessage.runtimeType, String);
    expect(carAddingFormBloc.state.errorMessage, '');
    expect(carAddingFormBloc.state.status.runtimeType, FormzStatus);
    expect(carAddingFormBloc.state.status, FormzStatus.pure);
  });
}
