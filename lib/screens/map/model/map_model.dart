import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart' show BuildContext, DefaultAssetBundle;
import 'package:weather_forecast/screens/map/data/map_data.dart';
export 'package:weather_forecast/screens/map/data/map_data.dart';
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;

class MapModel extends Model {
  var _cities = <City>[];
  City _currentCity;

  // public access
  List<City> get cities => _cities;

  City get currentCity => _currentCity;

  MapModel(BuildContext context) {
    _loadCitiesAsMapMarker(context);
    // _loadCurrentCityOrFirstCity();
  }

  void _loadCitiesAsMapMarker(BuildContext context) async {
    // 1. get user's current location
    LocationData _locationData = await _loadCurrentLocation();

    // if current location is not available, use Melbourne coordinate as default value
    final latitude = _locationData?.latitude ?? 37.81;
    final longitude = _locationData?.longitude ?? 144.96;

    // 2. load list of cities from local assets
    final String data = await DefaultAssetBundle.of(context)
        .loadString("assets/city_list.json");
    _cities = (jsonDecode(data) as List).map((e) => City.fromJson(e)).toList();

    // 3. filter to keep cities within 50km around current location

    _cities
        .where((element) =>
            _calculateDistance(
                element.coord.lat, element.coord.lon, latitude, longitude) <
            50)
        .toList()
          ..sort((a, b) => (_calculateDistance(
                      a.coord.lat, a.coord.lon, latitude, longitude) -
                  _calculateDistance(
                      b.coord.lat, b.coord.lon, latitude, longitude))
              .toInt());

    // 4. load weather info of these cities

    // 5. notify listeners and update UI
    notifyListeners();
  }

  Future<LocationData> _loadCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    do {
      _serviceEnabled = await location.serviceEnabled();

      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
      }

      if (!_serviceEnabled) {
        break;
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
      }

      if (_permissionGranted != PermissionStatus.granted) {
        break;
      }

      _locationData = await location.getLocation();
    } while (false);

    return _locationData;
  }

  double _calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    final distance = 12742 * asin(sqrt(a));

    print(distance);
    return distance;
  }
}
