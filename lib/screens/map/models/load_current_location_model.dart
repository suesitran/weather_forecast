import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:location/location.dart';
import 'package:weather_forecast/mvvm/mvvm_data.dart';

const DEFAULT_LATITUDE = 37.81;
const DEFAULT_LONGITUDE = 144.96;

class LoadCurrentLocationModel extends MutableProviderData<LatLng?> {
  LoadCurrentLocationModel(LatLng? geoPoint) : super(geoPoint);

  void loadCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData? _locationData;

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

    double _latitude = _locationData?.latitude ?? DEFAULT_LATITUDE;
    double _longitude = _locationData?.longitude ?? DEFAULT_LONGITUDE;

    super.value = LatLng(_latitude, _longitude);
  }
}