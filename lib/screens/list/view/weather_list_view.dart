import 'package:flutter/material.dart';
import 'package:weather_forecast/generated/l10n.dart';

class WeatherListView extends StatefulWidget {
  WeatherListView({Key key}) : super(key: key);

  @override
  _WeatherListViewState createState() {
    return _WeatherListViewState();
  }
}

class _WeatherListViewState extends State<WeatherListView> {
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
        title: Text(Strings.of(context).weather_forecast_title),
      ),
      body: Center(
        child: Text(Strings.of(context).to_be_updated),
      ),
    );
  }
}