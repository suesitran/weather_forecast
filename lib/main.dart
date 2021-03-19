import 'package:flutter/material.dart';
import 'package:weather_forecast/generated/l10n.dart';
import 'package:weather_forecast/navigation/routes.dart';
import 'package:weather_forecast/screens/cities/data/city_data.dart';
import 'package:weather_forecast/screens/cities/view/city_list_view.dart';
import 'package:weather_forecast/screens/list/view/weather_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather Forecast",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CityListView(),
      localizationsDelegates: [
        Strings.delegate,
      ],
      supportedLocales: Strings.delegate.supportedLocales,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => _generateWidgetDestination(context, settings));
      },
    );
  }

  Widget _generateWidgetDestination(BuildContext context, RouteSettings settings) {
    switch(settings.name) {
      case ViewWeatherForCity:
        return WeatherListView(settings.arguments as City);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(context).unknown_route),
      ),
      body: Center(
        child: Text(Strings.of(context).page_not_implemented),
      ),
    );
  }
}