import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather_forecast/generated/l10n.dart';
import 'package:weather_forecast/screens/cities/model/city_list_model.dart';
import 'package:weather_forecast/navigation/routes.dart';

class CityListView extends StatefulWidget {
  CityListView({Key key}) : super(key: key);

  @override
  _CityListViewState createState() {
    return _CityListViewState();
  }
}

class _CityListViewState extends State<CityListView> {
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
    return ScopedModel<CityListModel>(
      model: CityListModel(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.of(context).city_listing),
        ),
        body: ScopedModelDescendant<CityListModel>(
          builder: (context, child, model) => ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(model.cities[index].name),
                subtitle: Text(model.cities[index].country),
                onTap: () => Navigator.of(context).pushNamed(ViewWeatherForCity, arguments: model.cities[index]),
              ),
          itemCount: model.cities.length,),
        ),
      ),
    );
  }
}