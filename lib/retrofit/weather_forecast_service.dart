import 'package:dio/dio.dart';
import 'package:weather_forecast/retrofit/weather_forecast_client.dart';

class WeatherForecastService {
  static final instance = WeatherForecastService._internal();
  factory WeatherForecastService() {
    return WeatherForecastService._internal();
  }

  WeatherForecastClient? _client;

  WeatherForecastService._internal() {
    final dio = Dio();   // Provide a dio instance
    dio.options.headers["Demo-Header"] = "demo header";   // config your dio headers globally
    _client = WeatherForecastClient(dio);
  }

  Future<WeatherReportResponse?> loadWeatherReport3Hourly(String cityId, String appId) async {
    WeatherReportResponse? response;
    // try {
    response = await _client?.loadWeatherReport3Hourly(cityId, appId);
    // } catch(e) {
    //   print("Weather Forecast Client exception ${e.stracktrace}");
    // }

    return response;
  }
}