import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:queue/controllers/map.controller.dart';
import 'package:queue/views/home/widgets/map.widgets.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {

  
  MapType mapType = MapType.normal;


  final _mapCtrl = Get.find<MapController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Stack(
          children: [
            GoogleMap(
              polylines: Set<Polyline>.of(_mapCtrl.polylines.values),
              initialCameraPosition: CameraPosition(
                target: _mapCtrl.currentPosition.value,
                zoom: 15,
              ),
              markers:  Set<Marker>.of(_mapCtrl.markerList),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: mapType,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onTap: (latLng) {
                if (kDebugMode) {
                  print(latLng);
                }
              },
              onMapCreated: (GoogleMapController controller) async {
                _mapCtrl.mapController.value.complete(controller);
                final GoogleMapController mapCtrl = await _mapCtrl.mapController.value.future;
                rootBundle.loadString('assets/map_styles.json').then(
                  (mapStyle) {
                    mapCtrl.setMapStyle(mapStyle);
                  },
                );
              },
            ),


          MapWidgets().floatingButtons(
            zoomIn: () async {
              final GoogleMapController mapCtrl = await _mapCtrl.mapController.value.future;
              mapCtrl.animateCamera(CameraUpdate.zoomIn());
            },
            zoomOut: () async {
              final GoogleMapController mapCtrl = await _mapCtrl.mapController.value.future;
              mapCtrl.animateCamera(CameraUpdate.zoomOut());
            },
            getCurrentPoint: _mapCtrl.getCurrentLocation,
            changeMapType: () => setState(() {
              if(MapType.normal == mapType){
                mapType = MapType.satellite;
              } else {
                mapType = MapType.normal;
              }
            }),
            mapType: mapType
          ),

          ],
        );
      }
    );
  }



}