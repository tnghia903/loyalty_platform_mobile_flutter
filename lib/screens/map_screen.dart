import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerWithNetworkImage extends StatefulWidget {
  const CustomMarkerWithNetworkImage({Key? key}) : super(key: key);

  @override
  _CustomMarkerWithNetworkImageState createState() =>
      _CustomMarkerWithNetworkImageState();
}

class _CustomMarkerWithNetworkImageState
    extends State<CustomMarkerWithNetworkImage>
    with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller = Completer();
  @override
  bool get wantKeepAlive => true;
  List<String> images = [
    'assets/images/LoyaltyProgram_marker-05.png',
    'assets/images/LoyaltyProgram_marker-05.png',
    'assets/images/LoyaltyProgram_marker-05.png',
    'assets/images/LoyaltyProgram_marker-05.png',
    'assets/images/LoyaltyProgram_marker-05.png',
  ];
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLang = const [
    LatLng(10.790769618317784, 106.77883854032281),
    LatLng(10.788179045117827, 106.7732815865968),
    LatLng(10.79072952392506, 106.7759208803309),
    LatLng(10.79213122415708, 106.7723267201512),
    LatLng(10.792460537051642, 106.78081259844248),
  ];
  final List<String> _imagesDescriptions = [
    'https://scontent.fsgn13-3.fna.fbcdn.net/v/t39.30808-6/293188184_2928347514132059_6409086042527330552_n.jpg?stp=cp1_dst-jpg_s720x720&_nc_cat=108&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=BIGNR4DtWdQAX-IAEXz&_nc_ht=scontent.fsgn13-3.fna&oh=00_AT8qgjWLd8RMKlVAYpr_791yiyfb_raRbmTkafyJYID5EQ&oe=62DE7108',
    'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/292108197_2922629758037168_3950956926742487358_n.jpg?stp=cp1_dst-jpg_s720x720&_nc_cat=101&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=AFeSxai6T2kAX-cFrcN&_nc_ht=scontent.fsgn4-1.fna&oh=00_AT8u0CJ2JC7Sg8GKAZgtnzwOZD97MCffN-xg7tHSbPKZrQ&oe=62DD6B13',
    'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/291524376_2922057421427735_8176235057274848126_n.jpg?stp=cp1_dst-jpg_s720x720&_nc_cat=103&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=sempNO9kQVAAX8ovMFM&tn=8lBW6DPxYHwzRt7V&_nc_ht=scontent.fsgn4-1.fna&oh=00_AT8IsUkc8-602wEmliQFOOc9E80poRNMTY5B2VQn2ZpfAQ&oe=62DE7C60',
    'https://scontent.fsgn13-2.fna.fbcdn.net/v/t1.6435-9/94976524_2357653624534787_8191698330892369920_n.jpg?stp=dst-jpg_p403x403&_nc_cat=105&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=DiJy1RiQQbQAX8II_BR&_nc_ht=scontent.fsgn13-2.fna&oh=00_AT-Q5_79vpc5vs-yhmswPkG2-Ol5f2J9OzU6VDuNZPGbNA&oe=63004AD8',
    'https://scontent.fsgn8-2.fna.fbcdn.net/v/t1.6435-9/64317906_2117636838536468_5294192373717270528_n.jpg?stp=dst-jpg_s600x600&_nc_cat=100&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=oH4-Odr9PZwAX8aPPtm&_nc_ht=scontent.fsgn8-2.fna&oh=00_AT9sSSV14McO8yIUEmhFABPRtTAOKxlcHQSe2Qw4yCnpLg&oe=62FDAB67',
  ];
  final List<String> text = [
    'Mùa hè đến, the Lib đón thêm khách nhí đến chơi ',
    'Tuần mới làm việc hiệu quả, thêm nhiều ý tưởng ☕️',
    'Cuối tuần ngọt ngào với chocolate cookies 😍',
    'Happiness is a cup of coffee and real good book at weekend',
    'Buổi sáng đầu tuần nhâm nhi một ly cà phê và đọc một quyển sách để bản thân thư giãn sẵn sàng cho một tuần làm việc hiệu quả!',
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.791128408459018, 106.7766816000873),
    zoom: 15,
  );

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon =
          await getBytesFromAssets(images[i].toString(), 150);

      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _latLang[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          anchor: const Offset(.1, .1),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                NetworkImage(_imagesDescriptions[i].toString()),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Colors.red,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: SizedBox(
                        width: 150,
                        child: Text(
                          'Loyalty Program Coffee',
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(
                        text[i].toString(),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
              _latLang[i],
            );
          }));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tìm Cửa Hàng'),
        backgroundColor: Colors.purple,
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          onTap: (position) {
            _customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (position) {
            _customInfoWindowController.onCameraMove!();
          },
          onMapCreated: (GoogleMapController controller) async {
            _customInfoWindowController.googleMapController = controller;
          },
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 200,
          width: 300,
          offset: 35,
        ),
      ]),
    );
  }
}
