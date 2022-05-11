import '../models/coordinate_model.dart';

class CityModel {
  int? id;
  String? name;
  CoordinateModel? coord;
  String? country;
  int? population;
  int? timezone;

  CityModel({this.id, this.name, this.coord, this.country, this.population, this.timezone});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? CoordinateModel.fromJson(json['coord']) : null;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    data['country'] = country;
    data['population'] = population;
    data['timezone'] = timezone;

    return data;
  }
}
