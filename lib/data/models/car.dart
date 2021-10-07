class Car {
  final String id;
  final String brand;
  final String model;
  final String color;
  final String registration;
  final String year;
  final String ownerId;
  final double latitude;
  final double longitude;

  Car(
      {required this.id,
      required this.brand,
      required this.model,
      required this.color,
      required this.registration,
      required this.year,
      required this.ownerId,
      required this.latitude,
      required this.longitude});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['brand'],
      brand: json['brand'],
      model: json['model'],
      color: json['color'],
      registration: json['registration'],
      year: json['year'],
      ownerId: json['ownerId'],
      latitude: double.parse(json['lat'].toString().trim()),
      longitude: double.parse(json['lng'].toString().trim()),
    );
  }

  Car.from(Car car)
      : id = car.id,
        brand = car.brand,
        model = car.model,
        color = car.color,
        registration = car.registration,
        year = car.year,
        ownerId = car.ownerId,
        latitude = car.latitude,
        longitude = car.longitude;

  @override
  String toString() => 'Car with id: $id, $brand $model';
}
