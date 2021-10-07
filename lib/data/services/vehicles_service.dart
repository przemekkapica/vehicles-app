import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vehicles_app/data/models/dto/car_dto.dart';

class VehiclesService {
  final String _baseUrl =
      'https://vehicles-app-324723-default-rtdb.firebaseio.com/';

  final _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<List<dynamic>> getPersonList() async {
    final String personListUrl = _baseUrl + '/person-list.json';
    final response =
        await http.get(Uri.parse(personListUrl), headers: _headers);

    if (response.statusCode != 200) {
      throw new Exception(
          'Error getting person list: ' + response.reasonPhrase!);
    }
    return jsonDecode(response.body) as List;
  }

  Future<Map<dynamic, dynamic>> getCarList() async {
    final String carListUrl = _baseUrl + '/car-list.json';
    final response = await http.get(Uri.parse(carListUrl), headers: _headers);

    if (response.statusCode != 200) {
      final errorMessage = 'Error getting car list: ${response.reasonPhrase}';
      throw new Exception(errorMessage);
    }
    return jsonDecode(response.body) as Map;
  }

  Future<dynamic> addCar(CarDTO car) async {
    final String carListUrl = _baseUrl + '/car-list.json';

    final response = await http.post(Uri.parse(carListUrl),
        body: jsonEncode(<String, dynamic>{
          'brand': car.brand,
          'model': car.model,
          'color': car.color,
          'registration': car.registration,
          'year': car.year,
          'ownerId': car.ownerId,
          'lat': car.latitude,
          'lng': car.longitude,
        }));

    if (response.statusCode != 200) {
      throw new Exception('Car not added: ' + response.reasonPhrase!);
    }

    return jsonDecode(response.body) as dynamic;
  }
}
