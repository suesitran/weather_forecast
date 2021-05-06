import 'package:flutter/material.dart';
import 'package:weather_forecast/generated/l10n.dart';
import 'package:weather_forecast/screens/map/map_view_model.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MapView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final _vm = MapViewModel();

  final MapController _mapController =
      MapController(location: LatLng(0.0, 0.0),
      zoom: 10.0,);

  void _updateMapCenter(LatLng latLng) {
    _mapController.center = latLng;
  }

  void _onDoubleTap() {
    _mapController.zoom += 0.5;
  }

  Offset _dragStart = Offset(0.0, 0.0);
  double _scaleStart = 1.0;

  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      _mapController.zoom += 0.02;
    } else if (scaleDiff < 0) {
      _mapController.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart;
      _dragStart = now;
      _mapController.drag(diff.dx, diff.dy);
    }
  }

  @override
  void initState() {
    super.initState();
    _vm.cities.loadCitiesList(context);

    _vm.currentLocation.addListener(() {
      _updateMapCenter(_vm.currentLocation.value!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<ScreenState>(
        data: _vm,
        builder: (context, state) {
          if (state == ScreenState.LOADING) {}

          return state == ScreenState.LOADING
              ? Center(
                  child: Text(
                  Strings.of(context).loading,
                  style: TextStyle(color: Colors.black),
                ))
              : ProviderWidget<LatLng?>(
                  data: _vm.currentLocation,
                  builder: (context, currentLocation) =>
                      _buildMapWidget(currentLocation!));
        },
      ),
    );
  }

  Widget _buildMapWidget(LatLng currentLocation) => ProviderWidget<List<City>>(
        data: _vm.cities,
        builder: (context, cities) => GestureDetector(
          onDoubleTap: _onDoubleTap,
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          onScaleEnd: (details) {
            print(
                "Location: ${_mapController.center.latitude}, ${_mapController.center.longitude}");
          },
          child: Stack(
            children: [
              Map(
                controller: _mapController,
                builder: (context, x, y, z) {
                  final url =
                      'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                  return CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                  );
                },
              ),
              Center(
                child: Icon(Icons.close, color: Colors.red),
              ),
            ],
          ),
        ),
      );
}
