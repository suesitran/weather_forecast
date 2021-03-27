import 'package:flutter/material.dart';
import 'package:maps/maps.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather_forecast/screens/map/model/map_model.dart';

class MapPage extends StatelessWidget {
  MapPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapAdapter.defaultInstance = MapAdapter.platformSpecific(
      ios: AppleMapsNativeAdapter(),
      // android: GoogleMapsIframeAdapter(apiKey: MAP_API_KEY),
      otherwise: BingMapsIframeAdapter(),
    );

    return Scaffold(
      body: ScopedModel<MapModel>(
        model: MapModel(context),
        child: ScopedModelDescendant<MapModel>(
          builder: (context, child, model) => model.cities?.isEmpty == true
              ? Center(
                  child: Text("Loading..."),
                )
              : MapWidget(
                  location: MapLocation(
                      // geoPoint: GeoPoint(-37.68, 144.76),
                      geoPoint: model.cities?.isEmpty == true
                          ? GeoPoint(-37.68, 144.76)
                          : _coordToGeoPoint(model.cities.first.coord),
                      zoom: Zoom(12)),
                  markers: model.cities?.isEmpty == true
                      ? <MapMarker>{}
                      : model.cities
                          .map((e) => MapMarker(
                              id: e.id,
                              geoPoint: _coordToGeoPoint(e.coord),
                              details: MapMarkerDetails(
                                  snippet: e.id, title: e.name),
                              onTap: () => print('tap on ${e.name}'),
                              query: e.name))
                          ?.toSet(),
                  zoomGesturesEnabled: true,
          ),
        ),
      ),
    );
  }

  GeoPoint _coordToGeoPoint(Coord coord) {
    return GeoPoint(coord.lat, coord.lon);
  }
}
