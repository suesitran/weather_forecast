import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart' show BuildContext, DefaultAssetBundle;
import 'package:weather_forecast/screens/map/data/map_data.dart';
export 'package:weather_forecast/screens/map/data/map_data.dart';

class MapModel extends Model {
  var _cities = <City>[];

  // public access
  List<City> get cities => _cities;

  MapModel(BuildContext context) {
    _loadCitiesAsMapMarker(context);
    // _loadCurrentCityOrFirstCity();
  }

  void _loadCitiesAsMapMarker(BuildContext context) async {
    final String data = await DefaultAssetBundle.of(context).loadString("assets/city_list.json");

    _cities = (jsonDecode(data) as List).map((e) => City.fromJson(e)).toList();

    notifyListeners();
  }

}