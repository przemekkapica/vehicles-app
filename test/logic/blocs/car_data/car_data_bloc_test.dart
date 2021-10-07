import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vehicles_app/data/models/car.dart';
import 'package:vehicles_app/data/repositories/mock/car_repository.mocks.dart';
import 'package:vehicles_app/logic/blocs/car_data/bloc.dart';

class FakeCar extends Fake implements Car {
  FakeCar({required this.id});

  final String id;
}

void main() {
  late CarDataBloc carDataBloc;
  late MockCarRepository mockCarRepository;

  setUp(() {
    mockCarRepository = MockCarRepository();
    carDataBloc = CarDataBloc(carRepository: mockCarRepository);
  });

  tearDown(() {
    carDataBloc.close();
  });

  group('CarDataBloc test', () {
    test('Checks initial state', () async {
      expectLater(carDataBloc.state, CarListEmpty());
    });

    blocTest(
      'Gets cars list unsuccessfully',
      build: () {
        when(mockCarRepository.getCarList()).thenThrow(CarListError());
        return CarDataBloc(carRepository: mockCarRepository);
      },
      act: (CarDataBloc bloc) => bloc.add(GetCarList()),
      expect: () => [
        CarListLoading(),
        CarListError(),
      ],
    );

    List<Car> emptyCarList = [];
    blocTest(
      'Gets cars list successfully',
      build: () {
        when(mockCarRepository.getCarList())
            .thenAnswer((_) async => Future<List<Car>>.value(<Car>[]));
        return CarDataBloc(carRepository: mockCarRepository);
      },
      act: (CarDataBloc bloc) => bloc.add(GetCarList()),
      expect: () => [
        CarListLoading(),
        CarListLoaded(carList: emptyCarList),
      ],
    );
  });
}
