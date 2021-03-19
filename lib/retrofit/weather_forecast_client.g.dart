// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _WeatherForecastClient implements WeatherForecastClient {
  _WeatherForecastClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.openweathermap.org/data';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<WeatherReportResponse> loadWeatherReport3Hourly(cityId, appApi) async {
    ArgumentError.checkNotNull(cityId, 'cityId');
    ArgumentError.checkNotNull(appApi, 'appApi');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': cityId, r'appid': appApi};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/2.5/forecast',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = WeatherReportResponse.fromJson(_result.data);
    return value;
  }
}
