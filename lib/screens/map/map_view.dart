import 'package:flutter/material.dart';
import 'package:maps/maps.dart';
import 'package:weather_forecast/generated/l10n.dart';
import 'package:weather_forecast/screens/map/map_view_model.dart';

class MapView extends StatelessWidget {
  final _vm = MapViewModel();

  @override
  Widget build(BuildContext context) {
    MapAdapter.defaultInstance = MapAdapter.platformSpecific(
      ios: AppleMapsNativeAdapter(),
      // android: GoogleMapsIframeAdapter(apiKey: MAP_API_KEY),
      otherwise: BingMapsIframeAdapter(),
    );

    return Scaffold(
      body: ProviderWidget<ScreenState>(
        data: _vm,
        builder: (context, state) {
          if (state == ScreenState.LOADING) {
            _vm.cities.loadCitiesList(context);
          }

          return state == ScreenState.LOADING ? Center(
              child: Text(Strings.of(context).loading, style: TextStyle(color: Colors.black),))
              : ProviderWidget<GeoPoint>(data: _vm.currentLocation, builder: (context, currentLocation) => _buildMapWidget(currentLocation));
        },
      ),
    );
  }

  Widget _buildMapWidget(GeoPoint currentLocation) => ProviderWidget<List<City>>(data: _vm.cities, builder: (context, cities) => MapWidget(
    location: MapLocation(
        geoPoint: currentLocation,
        zoom: Zoom(12)),
    markers: cities.isEmpty == true
        ? <MapMarker>{}
        : cities.map((e) => MapMarker(
        id: e.id,
        geoPoint: _coordToGeoPoint(e.coord),
        details: MapMarkerDetails(
            snippet: e.id, title: e.name),
        onTap: () => print('tap on ${e.name}'),
        query: e.name))
        .toSet(),
    zoomGesturesEnabled: true,
    zoomControlsEnabled: true,
  ));
  GeoPoint _coordToGeoPoint(Coord coord) => GeoPoint(coord.lat, coord.lon);
}