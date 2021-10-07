import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicles_app/data/models/models.dart';
import 'package:vehicles_app/data/repositories/car_repository.dart';
import 'package:vehicles_app/logic/blocs/car_data/bloc.dart';

class CarDataBloc extends Bloc<CarDataEvent, CarDataState> {
  final CarRepository carRepository;

  CarDataBloc({required this.carRepository}) : super(CarListEmpty());

  Future<void> getCarList() async {
    await carRepository.getCarList();
    final List<Car> carList = await carRepository.getCarList();
    emit(CarListLoaded(carList: carList));
  }

  @override
  Stream<CarDataState> mapEventToState(CarDataEvent event) async* {
    if (event is GetCarList) {
      yield CarListLoading();
      try {
        final List<Car> carList = await carRepository.getCarList();
        yield CarListLoaded(carList: carList);
      } catch (_) {
        yield CarListError();
      }
    }
  }
}
