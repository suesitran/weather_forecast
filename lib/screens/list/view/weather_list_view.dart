import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather_forecast/navigation/routes.dart';
import 'package:weather_forecast/retrofit/weather_forecast_client.dart';
import 'package:weather_forecast/screens/cities/data/city_data.dart';
import 'package:weather_forecast/screens/list/model/weather_list_model.dart';
import 'package:intl/date_symbol_data_local.dart';

class WeatherListView extends StatefulWidget {
  final City _city;
  WeatherListView(this._city) : super();

  @override
  _WeatherListViewState createState() {
    return _WeatherListViewState();
  }
}

class _WeatherListViewState extends State<WeatherListView> {
  @override
  void initState() {
    super.initState();

    initializeDateFormatting('en_EN', null);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<WeatherListModel>(
      model: WeatherListModel(context, widget._city.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget._city.name),
        ),
        body: ScopedModelDescendant<WeatherListModel>(
          builder: (context, child, model) => ListView.builder(itemBuilder: (context, index) => ListTile(
            title: Text(model.weather[index].displayableDate),
            subtitle: Text(model.getWeatherSummary(model.weather[index].weatherInfo)),
            leading: Image.network(model.getWeatherIcon(model.weather[index].weatherInfo)),
            onTap: () => Navigator.pushNamed(context, ViewWeatherDetail, arguments: model.weather[index].weatherInfo),
          ),
          itemCount: model.weather.length,)),
      ),
    );
  }

}