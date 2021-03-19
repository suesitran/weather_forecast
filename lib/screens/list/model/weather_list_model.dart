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

  Map<int, String> iconMapper = {
    200 : '11',
    201 : '11',
    201	: '11',
    202	: '11',
    210	: '11',
    211	: '11',
    212	: '11',
    221	: '11',
    230	: '11',
    231	: '11',
    232 : '11',
    300	: '09',
    301	: '09',
    302	: '09',
    310	: '09',
    311	: '09',
    312	: '09',
    313	: '09',
    314	: '09',
    321	: '09',
    500	: '10',
    501 : '10',
    502 : '10',
    503 : '10',
    504 : '10',
    511 : '13',
    520 : '09',
    521 : '09',
    522	: '09',
    531 : '09',
    600 : '13',
    601	: '13',
    602	: '13',
    611	: '13',
    612	: '13',
    613	: '13',
    615	: '13',
    616	: '13',
    620	: '13',
    621	: '13',
    622	: '13',
    701	: '50',
    711	: '50',
    721	: '50',
    731	: '50',
    741	: '50',
    751	: '50',
    761	: '50',
    762	: '50',
    771	: '50',
    781	: '50',
    800 : '01',
    801 : '02',
    802 : '03',
    803 : '04',
    804 : '04'
  };

  void _loadWeatherDetailForCity(BuildContext context, String cityId) async {
    // load app ID from assets/weather_api_key
    final appId = await DefaultAssetBundle.of(context).loadString(
        'assets/weather_api_key');

    final response = await WeatherForecastService.instance
        .loadWeatherReport3Hourly(cityId, appId.trim());

    _weather.clear();

    Map<String, List<WeatherDetail>> map = {};

    response.list.forEach((element) {
      if (element.weather.length > 0) {
        // only use Info item when there's 'weather' detail
        final weatherDetail = WeatherDetail(element.weather.first.description, _getIconUrl(element.weather.first.id), element);
        final date = DateTime.fromMillisecondsSinceEpoch(
            element.dt * 1000, isUtc: true);
        map.update(_df.format(date), (value) => value..add(weatherDetail),
            ifAbsent: () => [weatherDetail]);
      }
    });

    map.forEach((key, value) {
      _weather.add(DisplayableWeather(key, value));
    });

    notifyListeners();
  }

  String _getIconUrl(int iconId) {
    String iconName = iconMapper[iconId];

    // use day icon for now, will udpate later
    String dayNightSuffix = 'd';

    return iconName == null ? null : "https://openweathermap.org/img/wn/$iconName$dayNightSuffix@2x.png";
  }
}