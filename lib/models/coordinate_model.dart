class CoordinateModel {
  double? lon;
  double? lat;

  CoordinateModel({this.lon, this.lat});

  CoordinateModel.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}
