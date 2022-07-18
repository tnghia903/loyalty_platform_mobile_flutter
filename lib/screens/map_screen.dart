import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../services/geolocator_services.dart';
import '../services/places_service.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => GeolocatorService().getLocation(),
          initialData: null,
        ),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context, position, places) {
            return PlacesService()
                .getPlaces(position.latitude, position.longitude);
          },
        )
      ],
      child: const MaterialApp(
        home: GetScreen(),
      ),
    );
  }
}

class GetScreen extends StatelessWidget {
  const GetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);
    if (currentPosition != null) {
      final placeService = Provider.of<Future<List<Place>?>>(context);
      // ignore: unnecessary_null_comparison
      if (placeService != null) {
        return FutureProvider(
            lazy: false,
            create: (context) => placeService,
            initialData: const [],
            child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  title: const Text('Tìm nhà hàng'),
                  elevation: 0,
                  backgroundColor: Colors.purple,
                  centerTitle: true,
                ),
                body: Consumer<List<Place>>(
                  builder: (context, places, child) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: LatLng(currentPosition.latitude,
                                    currentPosition.longitude),
                                zoom: 16.0),
                            zoomGesturesEnabled: true,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: places.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(
                                        places[index].name,
                                      ),
                                    ),
                                  );
                                }))
                      ],
                    );
                  },
                )));
      } else {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              title: const Text('Tìm nhà hàng'),
              elevation: 0,
              backgroundColor: Colors.purple,
              centerTitle: true,
            ),
            body: const Center(child: CircularProgressIndicator()));
      }
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          title: const Text('Tìm nhà hàng'),
          elevation: 0,
          backgroundColor: Colors.purple,
          centerTitle: true,
        ),
        body: const Center(child: CircularProgressIndicator()));
  }
}
