import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_forecast_client.g.dart';

@RestApi(baseUrl: "https://api.openweathermap.org/data")
abstract class WeatherForecastClient {
  factory WeatherForecastClient(Dio dio, {String baseUrl}) =
      _WeatherForecastClient;

  @GET("/2.5/forecast")
  Future<WeatherReportResponse> loadWeatherReport3Hourly();
}

class WeatherReportResponse {
  String cod;
  double message;
  int cnt;
  List<WeatherInfo> list;

  WeatherReportResponse.fromJson(Map<String, dynamic> json)
      : this.cod = json['cod'],
        this.message = json['message'],
        this.cnt = json['cnt'],
        this.list = (json['list'] as List).map((e) => WeatherInfo.fromJson(e));

  Map<String, dynamic> toJson() => {
        'cod': cod,
        'message': message,
        'cnt': cnt,
        'list': list.map((e) => e.toJson()).toList()
      };
}

class WeatherInfo {
  int dt;
  Main main;
  List<Weather> weather;
  Cloud clouds;
  Wind wind;
  Snow snow;
  Sys sys;
  String dt_txt;
  int visibility;

  WeatherInfo.fromJson(Map<String, dynamic> json)
      : this.dt = json['dt'],
        this.main = Main.fromJson(json['main']),
        this.weather =
            (json['weather'] as List).map((e) => Weather.fromJson(e)),
        this.clouds = Cloud.fromJson(json['clouds']),
        this.wind = Wind.fromJson(json['wind']),
        this.snow = Snow.fromJson(json['snow']),
        this.sys = Sys.fromJson(json['sys']),
        this.dt_txt = json['dt_txt'],
        this.visibility = json['visibility'];

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'main': main.toJson(),
        'weather': weather.map((e) => e.toJson()).toList(),
        'clouds': clouds.toJson(),
        'wind': wind.toJson(),
        'snow': snow.toJson(),
        'sys': sys.toJson(),
        'dt_txt': dt_txt,
        'visibility': visibility
      };
}

class Main {
  double temp;
  double temp_min;
  double temp_max;
  double pressure;
  double sea_level;
  double grnd_level;
  double humidity;
  double temp_kf;

  Main.fromJson(Map<String, dynamic> json)
      : this.temp = json['temp'],
        this.temp_min = json['temp_min'],
        this.temp_max = json['temp_max'],
        this.pressure = json['pressure'],
        this.sea_level = json['sea_level'],
        this.grnd_level = json['grnd_level'],
        this.humidity = json['humidity'],
        this.temp_kf = json['temp_kf'];

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'temp_min': temp_min,
        'temp_max': temp_max,
        'pressure': pressure,
        'sea_level': sea_level,
        'grnd_level': grnd_level,
        'humidity': humidity,
        'temp_kf': temp_kf
      };
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.main = json['main'],
        this.description = json['description'],
        this.icon = json['icon'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'main': main, 'description': description, 'icon': icon};
}

class Cloud {
  int all;

  Cloud.fromJson(Map<String, dynamic> json) : this.all = json['all'];

  Map<String, dynamic> toJson() => {'all': all};
}

class Wind {
  double speed;
  double deg;

  Wind.fromJson(Map<String, dynamic> json)
      : this.speed = json['speed'],
        this.deg = json['deg'];

  Map<String, dynamic> toJson() => {'speed': this.speed, 'deg': this.deg};
}

class Snow {
  Snow.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() => {};
}

class Sys {
  String pod;

  Sys.fromJson(Map<String, dynamic> json) : this.pod = json['pod'];

  Map<String, dynamic> toJson() => {'pod': pod};
}
