class CarDTO {
  final String brand;
  final String model;
  final String color;
  final String registration;
  final String year;
  final String ownerId;
  final double latitude;
  final double longitude;

  CarDTO(
      {required this.brand,
      required this.model,
      required this.color,
      required this.registration,
      required this.year,
      required this.ownerId,
      required this.latitude,
      required this.longitude});
}
