extension StringExtension on String {
  String capitalizeFirstLetter() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}

String formatRegistrationNumber(String registration) {
  return registration.toUpperCase().substring(0, registration.length - 5) +
      ' ' +
      registration.toUpperCase().substring(registration.length - 5);
}
