import 'package:dio/dio.dart';
import 'package:weather_forecast/retrofit/weather_forecast_client.dart';

class WeatherForecastService {
  static final instance = WeatherForecastService._internal();
  factory WeatherForecastService() {
    return WeatherForecastService._internal();
  }

  WeatherForecastClient _client;

  WeatherForecastService._internal() {
    final dio = Dio();   // Provide a dio instance
    dio.options.headers["Demo-Header"] = "demo header";   // config your dio headers globally
    _client = WeatherForecastClient(dio);
  }

  Future<WeatherReportResponse> loadWeatherReport3Hourly() => _client.loadWeatherReport3Hourly();
}