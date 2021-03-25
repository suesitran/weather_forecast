class City {
  String id;
  String name;
  String state;
  String country;
  Coord coord;

  City.fromJson(Map<String, dynamic> json)
      : this.id = "${json['id']}",
        this.name = json['name'],
        this.state = json['state'] ?? "",
        this.country = json['country'],
        this.coord = Coord.fromJson(json['coord']);
}

class Coord {
  double lat;
  double lon;

  Coord.fromJson(Map<String, dynamic> json) : this.lat = json['lat'], this.lon = json['lon'];
}
