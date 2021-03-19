import 'package:flutter/material.dart';
import 'package:weather_forecast/generated/l10n.dart';
import 'package:weather_forecast/retrofit/weather_forecast_client.dart';

class WeatherDetailView extends StatefulWidget {
  List<WeatherInfo> _info;
  WeatherDetailView(this._info) : super();

  @override
  _WeatherDetailViewState createState() {
    return _WeatherDetailViewState();
  }
}

class _WeatherDetailViewState extends State<WeatherDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._info.first.weather.first.main),
      ),
      body: Center(
        child: Text(Strings.of(context).to_be_updated),
      ),
    );
  }
}