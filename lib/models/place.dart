import 'package:loyalty_platform_mobile_flutter/models/geometry.dart';

class Place {
  final Geometry geometry;
  final String name;
  final double rating;
  final int userRatingCount;
  final String vicinity;

  Place(this.geometry, this.name, this.rating, this.userRatingCount,
      this.vicinity);

  Place.fromJson(Map<dynamic, dynamic> parsedJson)
      : geometry = Geometry.fromJson(parsedJson['geometry']),
        name = parsedJson['name'],
        rating = (parsedJson['rating'] != null)
            ? (parsedJson['rating'])!.toDouble()
            : 0.0,
        userRatingCount = (parsedJson['user_ratings_total'] != null)
            ? parsedJson['user_ratings_total']
            : 0,
        vicinity = parsedJson['vicinity'];
}
