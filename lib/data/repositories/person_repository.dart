import 'package:mockito/annotations.dart';
import 'package:vehicles_app/data/models/models.dart';
import 'package:vehicles_app/data/services/mock/vehicles_service.mocks.dart';
import 'package:vehicles_app/data/services/vehicles_service.dart';

class PersonRepository {
  final VehiclesService vehiclesService;

  const PersonRepository({required this.vehiclesService});

  Future<List<Person>> getPersonList() async {
    final rawPersonsList = await this.vehiclesService.getPersonList();

    return rawPersonsList.map((person) => Person.fromJson(person)).toList();
  }

  Future<Person> getPersonDetails(String id) async {
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
}

@GenerateMocks([PersonRepository])
void main() {
  MockVehiclesService mockVehiclesService = MockVehiclesService();
  var mockPersonRepository =
      PersonRepository(vehiclesService: mockVehiclesService);
}
