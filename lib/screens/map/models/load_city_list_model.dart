import 'package:flutter/material.dart' show BuildContext, DefaultAssetBundle;
import 'package:weather_forecast/mvvm/mvvm_data.dart';
import 'package:weather_forecast/screens/map/map_data.dart';
import 'dart:convert';

class LoadCityListModel extends MutableProviderData<List<City>> {
  LoadCityListModel(List<City> cities) : super(cities);

  void loadCitiesList(BuildContext context) async {
    final String data = await DefaultAssetBundle.of(context)
        .loadString("assets/city_list.json");

    List<City> cities = (jsonDecode(data) as List).map((e) => City.fromJson(e)).toList();

    super.value = cities.sublist(0, 30);
  }
}
