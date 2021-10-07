import 'package:flutter_test/flutter_test.dart';
import 'package:vehicles_app/data/models/car.dart';

void main() {
  late Car car;

  setUp(() {
    car = Car(
      id: 'id',
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

  group('Testing Car model class ', () {
    test('Check runtime types', () {
      expect(car.id.runtimeType, String);
      expect(car.brand.runtimeType, String);
      expect(car.model.runtimeType, String);
      expect(car.registration.runtimeType, String);
      expect(car.year.runtimeType, String);
      expect(car.ownerId.runtimeType, String);
      expect(car.color.runtimeType, String);
      expect(car.latitude.runtimeType, double);
      expect(car.longitude.runtimeType, double);
    });

    test('Test Car.from constructor', () {
      Car carFromCar = Car.from(car);
      expect(carFromCar.runtimeType, Car);
    });

    test('Test Car.fromJson constructor', () {
      Map<String, dynamic> carJson = {
        "_id": "5e5e40c4c0ea272d00000956",
        "brand": "Opel",
        "model": "Astra",
        "color": "#0fc0fc",
        "registration": "WA12345",
        "year": "2005-01-01T00:00:00.000Z",
        "ownerId": "5e5e3d7fc0ea272d00000824",
        "lat": 50.754,
        "lng": 12.2145,
        "_recent_changed": true
      };

      Car carFromJson = Car.fromJson(carJson);
      expect(carFromJson.runtimeType, Car);
    });
  });
}
