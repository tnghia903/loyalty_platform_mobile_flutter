import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loyalty_platform_mobile_flutter/models/place.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);
    final placesProvider = Provider.of<Future<List<Place>>?>(context);
    return FutureProvider(
      create: (context) => placesProvider,
      initialData: null,
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
          // ignore: unnecessary_null_comparison
          body: (currentPosition != null)
              ? Consumer<List<Place>?>(builder: (_, places, __) {
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
                              itemCount: places?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      places![index].name,
                                    ),
                                  ),
                                );
                              }))
                    ],
                  );
                })
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
