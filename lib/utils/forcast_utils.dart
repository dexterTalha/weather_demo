import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class Util {
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEE, MMM d').format(dateTime); //Tue, May 5, 2022
  }

  static String findIcon(String name, bool type) {
    if (type) {
      switch (name) {
        case "Clouds":
          return "assets/images/sunny.png";
        case "Rain":
          return "assets/images/rainy.png";
        case "Drizzle":
          return "assets/images/rainy.png";
        case "Thunderstorm":
          return "assets/images/thunder.png";
        case "Snow":
          return "assets/images/snow.png";
        default:
          return "assets/images/sunny.png";
      }
    } else {
      switch (name) {
        case "Clouds":
          return "assets/images/sunny_2d.png";
        case "Rain":
          return "assets/images/rainy_2d.png";
        case "Drizzle":
          return "assets/images/rainy_2d.png";
        case "Thunderstorm":
          return "assets/images/thunder_2d.png";
        case "Snow":
          return "assets/images/snow_2d.png";
        default:
          return "assets/images/sunny_2d.png";
      }
    }
  }
}
