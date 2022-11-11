
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:queue/app/config/app.asset.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/models/service.model.dart';
import 'package:queue/repository/matrix.repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';


class MapController extends GetxController {

  var servicex = {'loading': false, 'error': ''}.obs;
  var services = [].obs;
  RxList<Marker> markerList = <Marker>[].obs;
  
  var currentPosition = const LatLng(9.600952908429162, -13.64766251295805).obs;
  Rx<Completer<GoogleMapController>> mapController = Completer<GoogleMapController>().obs;
  RxMap<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;
  Rx<PolylinePoints> polylinePoints = PolylinePoints().obs;



  var distances = [].obs;
  RxList<ServiceModel> serviceModel = <ServiceModel>[].obs;
  
  /// new instance of ServiceModel after calculating and sorting coordinates by order
  RxList<ServiceModel> serviceModel2 = <ServiceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    // getServices();

    /// fake markers 
    serviceModel.value = fakeServices;
    getAllCoords();
  }




Position position(var lat, var lng){
  return Position(
    latitude: lat,
    longitude: lng,
    accuracy: 0.0,
    speed: 0.0,
    heading: 0.0,
    altitude: 0.0,
    timestamp: DateTime.now(),
    speedAccuracy: 0.0
  );
}


  addPolyLine(LatLng pointB) async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.value.getRouteBetweenCoordinates(
      AppConst.mapToken,
      PointLatLng(currentPosition.value.latitude, currentPosition.value.longitude),
      PointLatLng(pointB.latitude, pointB.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    // polyline ui
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppConst.green,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }


/// animate polyline trajet with camera
makePolilyne(LatLng pointB) async {
  List<LatLng> polylineCoordinates = [];
  final GoogleMapController mapCtrl = await mapController.value.future; 



  addPolyLine(pointB);
  mapCtrl.animateCamera(
    CameraUpdate.newLatLngBounds(
      LatLngBounds(
        northeast: LatLng(
          currentPosition.value.latitude,
          currentPosition.value.longitude,
        ),
        southwest: LatLng(
          pointB.latitude,
          pointB.longitude,
        ),
      ),
      10.0, 
    ),
  );
}


  getCurrentLocation() async {
    final GoogleMapController mapCtrl = await mapController.value.future;
    await Geolocator.getCurrentPosition().then((Position position) async {
      mapCtrl.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );
      currentPosition.value = LatLng(position.latitude, position.longitude);
    }).catchError((e) {});
  }


  getAllCoords() async {
    if(serviceModel.isNotEmpty){
      for(int i = 0; i<serviceModel.length; i++){

        /// calculate distance between two coordinates
        var data = await MatrixRepository.matrix(
          c1: position(currentPosition.value.latitude, currentPosition.value.longitude),
          c2: position(serviceModel[i].location.latitude, serviceModel[i].location.longitude), 
          apiKey: AppConst.mapToken
        );

        serviceModel2.add(
          ServiceModel(
            documentId: i.toString(), 
            name: serviceModel[i].name, 
            phoneNumber: serviceModel[i].phoneNumber, 
            description: serviceModel[i].description, 
            address: serviceModel[i].address, 
            location: serviceModel[i].location, 
            distance: data[0].toString(), 
            time: data[1].toString(),
          )
        );
      }

      ///Now make a sorting by distance of serviceModel2
      await Future.delayed(100.milliseconds, (){
        serviceModel2.sort((a, b) => a.distance.compareTo(b.distance));
      });

      /// after calculating and sorting coordinates by order 
      servicex['loading'] = false;
    }

    /// show markers on map
    showMarkers(serviceModel2);
  }


  Future<void> getServices() async {
    // servicex['loading'] = true;
    // HomeRepository().getServices().then((value) {
    //   serviceModel.clear();
    //   serviceModel2.clear();
    //   List<ServiceModel> newValue = value.map(((e) => ServiceModel.fromJson(e))).toList();
    //   serviceModel.addAll(newValue);
    //   getAllCoords();
    // })
    // .onError((AppException error, stackTrace) {
    //   servicex['error'] = '${error.code}-${error.message}';
    // })
    // .whenComplete(() {
    //   servicex['loading'] = false;
    // });
  }
    



  Future<void> loadFakeServices() async {

  }




  showMarkers(List<ServiceModel> markers) async {
      final markIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(5.0, 5.0), devicePixelRatio: 0.5),
        AppAsset.mapPin
      );
      for (var item in markers) {
        markerList.add(
          Marker(
            markerId: MarkerId(item.documentId!),
            position: item.location,
            icon: markIcon,
            onTap: () {
              Get.bottomSheet(
                VxBox(
                  child: VStack([
                    Center(
                      child:VxBox().gray300.size(50, 5).withRounded(value:5).make().pSymmetric(v:5)
                    ),
                    7.heightBox,
                    item.name.text.xl3.bold.make(),
                    10.heightBox,
                    item.address.text.lg.make(),
                    5.heightBox,
                    [
                      const Icon(MaterialCommunityIcons.map_marker_distance, color: Vx.gray600, size: 20),
                      10.widthBox,
                      "Distance: ${item.distance} km".text.base.gray600.make()
                    ].hStack(),
                    10.heightBox,

                    [
                      const Icon(Icons.timer, color: Vx.gray600, size: 20),
                      10.widthBox,
                      "Durée du trajet: ${item.time}".text.base.gray600.make()
                    ].hStack(),
                    10.heightBox,

                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        [
                          Image.asset(AppAsset.route, height: 30.0, width: 30.0),
                          10.widthBox,
                          "Trajet".text.base.gray600.make()
                        ].hStack().p(10).box.blue50.border(color: Vx.blue200, width: 3.0).rounded.make().onInkTap(() {
                            Get.back();
                            makePolilyne(item.location);
                        }),
                        10.widthBox,
                        [
                          Image.asset(AppAsset.car, height: 30.0, width: 30.0),
                          10.widthBox,
                          "Aller à".text.base.gray600.make()

                        ].hStack().p(10).box.blue50.border(color: Vx.blue200, width: 3.0).rounded.make().onInkTap(() async { 
                          await launchUrl(
                              Uri.parse(
                                'google.navigation:q=${item.location.latitude},${item.location.longitude}&key=${AppConst.mapToken}',
                              ),
                            );
                        })
                      ],
                    ).p(10),
                  ]).p(10)
                ).white.topRounded(value: 20).shadow.make(),
                isScrollControlled: true,
              );
            }
          )
        );
      }
    }
}