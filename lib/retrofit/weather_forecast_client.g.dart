// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _WeatherForecastClient implements WeatherForecastClient {
  _WeatherForecastClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.openweathermap.org/data';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<WeatherReportResponse> loadWeatherReport3Hourly(cityId, appApi) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': cityId, r'appid': appApi};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WeatherReportResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/2.5/forecast',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WeatherReportResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
