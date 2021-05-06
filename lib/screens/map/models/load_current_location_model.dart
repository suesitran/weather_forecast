import 'package:flutter/material.dart';
import 'package:maps/maps.dart';
import 'package:location/location.dart';
import 'package:weather_forecast/mvvm/mvvm_data.dart';

const DEFAULT_LATITUDE = 37.81;
const DEFAULT_LONGITUDE = 144.96;

class LoadCurrentLocationModel extends MutableProviderData<GeoPoint> {
  LoadCurrentLocationModel(GeoPoint geoPoint) : super(geoPoint);

  void loadCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    do {
      _serviceEnabled = await location.serviceEnabled();

      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
      }

      if (!_serviceEnabled) {
        break;
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
      }

      if (_permissionGranted != PermissionStatus.granted) {
        break;
      }

      _locationData = await location.getLocation();
    } while (false);

    print("location data $_locationData");
    double _latitude = _locationData?.latitude ?? DEFAULT_LATITUDE;
    double _longitude = _locationData?.longitude ?? DEFAULT_LONGITUDE;

    super.value = GeoPoint(_latitude, _longitude);
  }
}