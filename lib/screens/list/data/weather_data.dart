import 'package:weather_forecast/retrofit/weather_forecast_client.dart';

class DisplayableWeather {
  String displayableDate;
  List<WeatherDetail> weatherInfo;

  DisplayableWeather(this.displayableDate, this.weatherInfo);
}

class WeatherDetail {
  String summary; // map to description field
  String iconUrl;
  WeatherInfo weatherInfo;

  WeatherDetail(this.summary, this.iconUrl, this.weatherInfo);
}