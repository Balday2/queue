import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:latlong2/latlong.dart' as latlong;
import 'package:queue/models/marker.model.dart';
import 'package:queue/views/home/widgets/map.widgets.dart';
import 'package:queue/views/home/widgets/service.details.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  // GoogleMapController? _controller;
  Completer<GoogleMapController> mapController = Completer();
  final List<Marker> markers = <Marker>[];
  final pageController = PageController();

  

  // static latlong.LatLng myLocation = latlong.LatLng(-12.0080041, -77.0778237);
  Position? currentPosition;
  loadMarkers() async {
    for (var i = 0; i < mapMarkers.length; i++) {
      final markIcons = await  BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(5.0, 5.0),
          devicePixelRatio: 1.2
        ),
        mapMarkers[i].image
      );
      markers.add(
        Marker(
          markerId: MarkerId('${mapMarkers[i].location}'),
          position: mapMarkers[i].location,
          infoWindow: InfoWindow(
            title: mapMarkers[i].title,
            snippet: mapMarkers[i].address,
          ),
          icon: markIcons,
          onTap: (){
            pageController.animateToPage(
              i, duration: const Duration(milliseconds: 500), 
              curve: Curves.elasticInOut
            );
            print("Selected: ${mapMarkers[i].address}");
          }
        )
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadMarkers();
    getCurrentLocation();
  }
  BitmapDescriptor? icon;



  

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) async {
              mapController.complete(controller);
              final GoogleMapController mapCtrl = await mapController.future; 
              rootBundle.loadString('assets/map_styles.json').then((mapStyle) {
                mapCtrl.setMapStyle(mapStyle);
              });
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(0,0),
              zoom: 16,
            ),
            markers: Set<Marker>.of(markers),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              minMaxZoomPreference: const MinMaxZoomPreference(5, 16),
              zoomControlsEnabled: false,
          ),

          // MapWidgets().serviceDetails(
          //   marker: mapMarkers,
          //   controller: pageController
          // ),

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
                itemBuilder: (context, index){
                  return ServiceDetails(
                    marker: mapMarkers[index]
                  );
                },
              ),
            // ).roundedLg.white.make().p(20)
          ),

          MapWidgets().zoomButton(
            zoomIn: () async {
              final GoogleMapController mapCtrl = await mapController.future;
              mapCtrl.animateCamera(
                CameraUpdate.zoomIn(),
              );
            },
            zoomOut: () async {
              final GoogleMapController mapCtrl = await mapController.future; 
              mapCtrl.animateCamera(
                CameraUpdate.zoomOut(),
              );
            },
          ),

          MapWidgets().currentLocationButton(
              onTap: () async {
                final GoogleMapController mapCtrl = await mapController.future; 
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
            )
        ],
      );
  }


  /// Method for retrieving the current location
  getCurrentLocation() async {
    final GoogleMapController mapCtrl = await mapController.future; 
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
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
}

