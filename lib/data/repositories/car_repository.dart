import 'package:mockito/annotations.dart';
import 'package:vehicles_app/data/models/dto/car_dto.dart';
import 'package:vehicles_app/data/models/models.dart';
import 'package:vehicles_app/data/services/mock/vehicles_service.mocks.dart';
import 'package:vehicles_app/data/services/vehicles_service.dart';

class CarRepository {
  final VehiclesService vehiclesService;

  const CarRepository({required this.vehiclesService});

  Future<List<Car>> getCarList() async {
    final rawCarList = await this.vehiclesService.getCarList();

    List<Car> carList = [];
    for (var carEntry in rawCarList.entries) {
      Car car = Car(
        id: carEntry.key,
        brand: carEntry.value['brand'],
        model: carEntry.value['model'],
        latitude: double.parse(carEntry.value['lat'].toString().trim()),
        longitude: double.parse(carEntry.value['lng'].toString().trim()),
        year: carEntry.value['year'],
        registration: carEntry.value['registration'],
        ownerId: carEntry.value['ownerId'],
        color: carEntry.value['color'],
      );

      carList.add(car);
    }

    carList = filterCarListByRegistration(carList);

    return carList;
  }

  Future<Person> getOwnerDetails(String id) async {
    final rawPersonsList = await this.vehiclesService.getPersonList();
    rawPersonsList.map((person) => Person.fromJson(person)).toList();

    Person requestedPerson = Person(
        id: 'not_found', firstName: '', lastName: '', birthDate: '', sex: '');

    rawPersonsList.forEach((element) {
      if (Person.fromJson(element).id == id) {
        requestedPerson = Person.fromJson(element);
      }
    });
    return requestedPerson;
  }

  Future<dynamic> addCar(CarDTO car) async {
    final addCarResponse = await this.vehiclesService.addCar(car);
    return addCarResponse;
  }

  List<Car> filterCarListByRegistration(List<Car> carList) {
    RegExp casualRegistrationRegex = new RegExp(r'^[A-Z]{2,3}\s?[A-Z0-9]{5}$',
        caseSensitive: false); // ex. SK 3829W
    RegExp orderedRegistrationRegex = new RegExp(
        r'^[A-Z]{1}[0-9]{1}\s?[A-Z0-9]{4,5}$',
        caseSensitive: false); // ex. E0 BOSS

    carList = carList
        .where((car) =>
            orderedRegistrationRegex.hasMatch(car.registration) ||
            casualRegistrationRegex.hasMatch(car.registration))
        .toList();

    return carList;
  }
}

@GenerateMocks([CarRepository])
void main() {
  MockVehiclesService mockVehiclesService = MockVehiclesService();
  var mockCarRepository = CarRepository(vehiclesService: mockVehiclesService);
}
