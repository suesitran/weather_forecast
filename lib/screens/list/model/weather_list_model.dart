import 'package:flutter/material.dart' show BuildContext, DefaultAssetBundle;
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather_forecast/retrofit/weather_forecast_client.dart';
import 'package:weather_forecast/retrofit/weather_forecast_service.dart';
import 'package:weather_forecast/screens/list/data/weather_data.dart';

class WeatherListModel extends Model {
  WeatherListModel(BuildContext context, String id) {
    _loadWeatherDetailForCity(context, id);
  }

  List<DisplayableWeather> _weather = [];

  List<DisplayableWeather> get weather => _weather;

  DateFormat _df = DateFormat.yMMMMd();

  void _loadWeatherDetailForCity(BuildContext context, String cityId) async {
    // load app ID from assets/weather_api_key
    final appId = await DefaultAssetBundle.of(context).loadString(
        'assets/weather_api_key');

    final response = await WeatherForecastService.instance
        .loadWeatherReport3Hourly(cityId, appId.trim());

    _weather.clear();

    Map<String, List<WeatherInfo>> map = {};

    response.list.forEach((element) {
      if (element.weather.length > 0) {
        // only use Info item when there's 'weather' detail
        final date = DateTime.fromMillisecondsSinceEpoch(
            element.dt * 1000, isUtc: true);
        map.update(_df.format(date), (value) => value..add(element),
            ifAbsent: () => [element]);
      }
    });

    map.forEach((key, value) {
      _weather.add(DisplayableWeather(key, value));
    });

    notifyListeners();
  }
}