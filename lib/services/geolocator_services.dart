import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getLocation() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
