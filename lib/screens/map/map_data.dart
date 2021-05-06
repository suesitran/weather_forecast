import 'dart:math' show cos, sqrt, asin;

class City {

  String id;
  String name;
  String state;
  String country;
  Coord coord;
  double distance = 0;

  City.fromJson(Map<String, dynamic> json)
      : this.id = "${json['id']}",
        this.name = json['name'],
        this.state = json['state'] ?? "",
        this.country = json['country'],
        this.coord = Coord.fromJson(json['coord']);
  City(this.id, this.name, this.state, this.country, this.coord);

  void calculateDistance(lat1, lon1) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((this.coord.lat - lat1) * p) / 2 +
        c(lat1 * p) * c(this.coord.lat * p) * (1 - c((this.coord.lon- lon1) * p)) / 2;
    distance = 12742 * asin(sqrt(a));
  }
}

class Coord {
  double lat;
  double lon;

  Coord.fromJson(Map<String, dynamic> json) : this.lat = json['lat'], this.lon = json['lon'];
  Coord(this.lat, this.lon);
}
