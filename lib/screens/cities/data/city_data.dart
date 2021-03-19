class City {
  String id;
  String name;
  String state;
  String country;

  City.fromJson(Map<String, dynamic> json)
      : this.id = "${json['id']}",
        this.name = json['name'],
        this.state = json['state'] ?? "",
        this.country = json['country'];
}
