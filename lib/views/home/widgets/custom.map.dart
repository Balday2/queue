import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/views/home/widgets/map.widgets.dart';
import 'package:queue/views/home/widgets/service.details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:queue/models/marker.model.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  Completer<GoogleMapController> mapController = Completer();
  Position? currentPosition;
  // final Completer<GoogleMapController?> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  LatLng curLocation = const LatLng(9.740040392052139, -13.558014921874989);
  LatLng destLocation = const LatLng(9.7224444846201, -13.55595498535147);
  StreamSubscription<loc.LocationData>? locationSubscription;
  final pageController = PageController();
  final List<Marker> markers = <Marker>[];

  loadMarkers() async {
    for (var i = 0; i < mapMarkers.length; i++) {
      final markIcons = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(5.0, 5.0), devicePixelRatio: 1.2),
          mapMarkers[i].image);
      markers.add(Marker(
          markerId: MarkerId('${mapMarkers[i].location}'),
          position: mapMarkers[i].location,
          infoWindow: InfoWindow(
            title: mapMarkers[i].title,
            snippet: mapMarkers[i].address,
          ),
          icon: markIcons,
          onTap: () {
            pageController.animateToPage(i,
                duration: const Duration(milliseconds: 500),
                curve: Curves.elasticInOut);
            print("Selected: ${mapMarkers[i].address}");
          }));
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadMarkers();
    getCurrentLocation();
    getNavigation();
    addMarker();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(sourcePosition == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Stack(
      children: [
        GoogleMap(
          polylines: Set<Polyline>.of(polylines.values),
          initialCameraPosition: CameraPosition(
            target: curLocation,
            zoom: 18,
          ),
          markers:  {sourcePosition!, destinationPosition!},
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          onTap: (latLng) {
            if (kDebugMode) {
              print(latLng);
            }
          },
          onMapCreated: (GoogleMapController controller) async {
            mapController.complete(controller);
            final GoogleMapController mapCtrl =
                await mapController.future;
            rootBundle.loadString('assets/map_styles.json').then(
              (mapStyle) {
                mapCtrl.setMapStyle(mapStyle);
              },
            );
          },
        ),
        
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          height: Get.height * 0.3,
          child:
              // VxBox(
              //   child:
              PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            itemCount: mapMarkers.length,
            itemBuilder: (context, index) {
              return ServiceDetails(marker: mapMarkers[index]);
            },
          ),
          // ).roundedLg.white.make().p(20)
        ),
        MapWidgets().itineraryButton(
          onTap: () async {
            await launchUrl(
              Uri.parse(
                'google.navigation:q=9.7224444846201, -13.55595498535147&key=${AppConst.mapToken}',
              ),
            );
          },
        ),
        MapWidgets().zoomButton(
          zoomIn: () async {
            final GoogleMapController mapCtrl =
                await mapController.future;
            mapCtrl.animateCamera(
              CameraUpdate.zoomIn(),
            );
          },
          zoomOut: () async {
            final GoogleMapController mapCtrl =
                await mapController.future;
            mapCtrl.animateCamera(
              CameraUpdate.zoomOut(),
            );
          },
        ),
        MapWidgets().currentLocationButton(
          onTap: () async {
            final GoogleMapController mapCtrl =
                await mapController.future;
            mapCtrl.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(
                    currentPosition!.latitude,
                    currentPosition!.longitude,
                  ),
                  zoom: 15.0,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  /// Method for retrieving the current location
  getCurrentLocation() async {
    final GoogleMapController mapCtrl = await mapController.future;
    await Geolocator.getCurrentPosition(
            // desiredAccuracy: loc.LocationAccuracy.high
            )
        .then((Position position) async {
      setState(() {
        currentPosition = position;
        print('\n\n\n\n CURRENT POSITION: $currentPosition');
        mapCtrl.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15.0,
            ),
          ),
        );
      });
      // await _getAddress();
    }).catchError((e) {
      print("\n\n\n error:: $e");
    });
  }

  getNavigation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    GoogleMapController? controller = await mapController.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = await location.getLocation();
      curLocation =
          LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocation) {
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 12,
        )));
        if (mounted) {
          controller
              .showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
          setState(() {
            curLocation =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
            sourcePosition = Marker(
              markerId: MarkerId(currentLocation.toString()),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              infoWindow: InfoWindow(
                  title:
                      '${double.parse((getDistance(const LatLng(9.7224444846201, -13.55595498535147)).toStringAsFixed(2)))} km'),
              onTap: () {
                if (kDebugMode) {
                  print('market tapped');
                }
              },
            );
          });
          getDirections(const LatLng(9.7224444846201, -13.55595498535147));
        }
      });
    }
  }

  getDirections(LatLng dst) async {
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        AppConst.mapToken,
        PointLatLng(curLocation.latitude, curLocation.longitude),
        PointLatLng(dst.latitude, dst.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        points.add({'lat': point.latitude, 'lng': point.longitude});
      }
    } else {
      if (kDebugMode) {
        print(result.errorMessage);
      }
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double getDistance(LatLng destposition) {
    return calculateDistance(curLocation.latitude, curLocation.longitude,
        destposition.latitude, destposition.longitude);
  }

  addMarker() {
    setState(() {
      sourcePosition = Marker(
        markerId: const MarkerId('source'),
        position: curLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        onTap: () {
          print(curLocation);
        },
      );
      destinationPosition = Marker(
        markerId: const MarkerId('destination'),
        position: destLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        onTap: () {
          print(destLocation);
        },
      );
    });
  }

}