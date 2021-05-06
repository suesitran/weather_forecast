import 'package:weather_forecast/mvvm/mvvm_data.dart';
import 'package:weather_forecast/screens/map/models/load_city_list_model.dart';
import 'package:weather_forecast/screens/map/models/load_current_location_model.dart';

export 'package:weather_forecast/mvvm/mvvm_data.dart';
export 'package:weather_forecast/screens/map/map_data.dart';

class MapViewModel extends MutableProviderData<ScreenState> {
  LoadCurrentLocationModel currentLocation = LoadCurrentLocationModel(null);
  LoadCityListModel cities = LoadCityListModel([]);


  MapViewModel() : super(ScreenState.LOADING) {
    currentLocation.addListener(_updateState);
    cities.addListener(_updateState);

    currentLocation.loadCurrentLocation();
  }

  void _updateState() {
    if (currentLocation.value != null && cities.value?.isNotEmpty == true) {
      super.value = ScreenState.IDLE;
    }
  }
}

enum ScreenState {
  LOADING,
  IDLE,
  ERROR
}