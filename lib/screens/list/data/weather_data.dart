import 'package:weather_forecast/retrofit/weather_forecast_client.dart';

class DisplayableWeather {
  String displayableDate;
  List<WeatherInfo> weatherInfo;

  DisplayableWeather(this.displayableDate, this.weatherInfo);
}