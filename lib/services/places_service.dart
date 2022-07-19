import 'package:loyalty_platform_mobile_flutter/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyAoBrNYerxKrpEoJpd06E0tkneGCd5y8Gc';

  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=restaurant&rankby=distance&key=$key '));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    List<Place> places =
        jsonResults.map((place) => Place.fromJson(place)).toList();
    return places;
  }
}
