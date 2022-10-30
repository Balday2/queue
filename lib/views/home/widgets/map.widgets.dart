import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/models/marker.model.dart';
import 'package:queue/views/home/widgets/service.details.dart';
import 'package:velocity_x/velocity_x.dart';

class MapWidgets {
  /// show zoom button
  Widget zoomButton({required Function() zoomIn, required Function() zoomOut}) {
    return SafeArea(
      child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 150.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Vx.blue300, // button color
                  child: InkWell(
                      splashColor: Colors.black26,
                      onTap: zoomIn, // inkwell color
                      child: const SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.add, color: Vx.white),
                      )),
                ),
                const SizedBox(height: 10),
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Vx.blue300, // button color
                  child: InkWell(
                      splashColor: Colors.black26,
                      onTap: zoomOut, // inkwell color
                      child: const SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.remove, color: Vx.white),
                      )),
                ),
              ],
            ),
          )),
    );
  }

  /// custom marker
  // declared method to get Images
  Future<Uint8List> customMarker(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  /// show current location button
  Widget currentLocationButton({required Function() onTap}) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 80.0),
          child: ClipOval(
            child: Material(
              color: AppConst.green,
              child: InkWell(
                  splashColor: Colors.black26,
                  onTap: onTap,
                  child: const SizedBox(
                    width: 35,
                    height: 35,
                    child: Icon(
                      Icons.my_location,
                      color: Vx.white,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget serviceDetails(
      {required List<MarkerModel> marker, required PageController controller}) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 20,
      height: Get.height * 0.3,
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        itemCount: marker.length,
        itemBuilder: (context, index) {
          return ServiceDetails(marker: marker[index]);
        },
      ),
    );
  }

  Widget itineraryButton({
    required Function() onTap,
  }) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 300),
          child: ClipOval(
            child: Material(
              color: AppConst.blue,
              child: InkWell(
                splashColor: Colors.black26,
                onTap: onTap,
                child: const SizedBox(
                  width: 35,
                  height: 35,
                  child: Icon(
                    Icons.navigation_outlined,
                    color: Vx.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );   
  }
}
