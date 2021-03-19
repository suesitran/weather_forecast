import 'dart:convert';

import 'package:flutter/material.dart' show BuildContext, DefaultAssetBundle;
import 'package:scoped_model/scoped_model.dart';
import 'package:weather_forecast/screens/cities/data/city_data.dart';

class CityListModel extends Model {
  List<City> _cities = [];

  List<City> get cities => _cities;

  CityListModel(BuildContext context) {
    _loadCities(context);
  }

  void _loadCities(BuildContext context) async {
    final String data = await DefaultAssetBundle.of(context).loadString("assets/city_list.json");

    _cities = (jsonDecode(data) as List).map((e) => City.fromJson(e)).toList();

    notifyListeners();
  }
}