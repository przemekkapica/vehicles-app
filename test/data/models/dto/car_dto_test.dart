import 'package:flutter_test/flutter_test.dart';
import 'package:vehicles_app/data/models/dto/car_dto.dart';

void main() {
  late CarDTO car;

  setUp(() {
    car = CarDTO(
      brand: 'brand',
      model: 'model',
      registration: 'regr',
      year: 'year',
      ownerId: 'id',
      color: 'color',
      latitude: 10.0,
      longitude: 10.0,
    );
  });

  group('Testing CarDTO model class ', () {
    test('Check runtime types', () {
      expect(car.brand.runtimeType, String);
      expect(car.model.runtimeType, String);
      expect(car.registration.runtimeType, String);
      expect(car.year.runtimeType, String);
      expect(car.ownerId.runtimeType, String);
      expect(car.color.runtimeType, String);
      expect(car.latitude.runtimeType, double);
      expect(car.longitude.runtimeType, double);
    });
  });
}
