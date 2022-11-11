import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:queue/app/config/app.asset.dart';
import 'dart:ui' as ui;
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/controllers/config.controller.dart';
import 'package:velocity_x/velocity_x.dart';

class MapWidgets {


  Widget floatingButtons(
    { 
      required Function() zoomIn, required Function() zoomOut, 
      required Function() getCurrentPoint, required Function() changeMapType,
      required MapType mapType
    }) {
    return SafeArea(
      child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: AppBar().preferredSize.height, right: 20.0),
            child: Column(
              children: <Widget>[

                /// show zoom button
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Vx.blue300, // button color
                  child: InkWell(
                    splashColor: Colors.black26,
                    onTap: zoomIn, // inkwell color
                    child: const SizedBox(
                      width: 35,
                      height: 35,
                      child: Icon(Icons.add, color: Vx.white),
                    )
                  ),
                ),
                const SizedBox(height: 5),
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Vx.blue300, // button color
                  child: InkWell(
                    splashColor: Colors.black26,
                    onTap: zoomOut, // inkwell color
                    child: const SizedBox(
                      width: 35,
                      height: 35,
                      child: Icon(Icons.remove, color: Vx.white),
                    )
                  ),
                ),
                const SizedBox(height: 30),

                /// show current location button
                Material(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: getCurrentPoint,
                    child: const SizedBox(
                      width: 35,
                      height: 35,
                      child: Icon(Icons.my_location,color: Vx.white),
                    )
                  ),
                ),

                const SizedBox(height: 20),
                InkWell(
                  splashColor: Colors.white,
                  onTap: changeMapType,
                  child: Stack(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          margin: const EdgeInsets.only(top: 10, left: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              mapType != MapType.normal
                              ? AppAsset.roadMap
                              : AppAsset.satelliteMap,
                              fit: BoxFit.fill
                            )
                          )
                        ),

                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              mapType == MapType.normal
                              ? AppAsset.roadMap
                              : AppAsset.satelliteMap,
                              fit: BoxFit.fill
                            )
                          )
                        ),
                      ],
                  )
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



  /// bottom bar
  Widget bottomBar() {
    final configCtrl = Get.find<ConfigController>();
    return Obx(() {
        return Positioned(
            bottom: 30.0,
            right: 65,
            left: 65,
            child: VxBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const Icon(FontAwesome.map_pin, color: Vx.gray600).p(10).box.roundedFull.color(
                      configCtrl.bottomBarIndex.value == 0
                        ? AppConst.green.withOpacity(0.5)
                        : Colors.white
                    ).make().onInkTap(() => configCtrl.bottomBarIndex.value = 0),

                    const Icon(MaterialCommunityIcons.map_search, color: Vx.gray600).p(10).box.roundedFull.color(
                      configCtrl.bottomBarIndex.value == 1
                        ? AppConst.green.withOpacity(0.5)
                        : Colors.white
                    ).make().onInkTap(() => configCtrl.bottomBarIndex.value = 1),

                    const Icon(MaterialCommunityIcons.file_document_outline, color: Vx.gray600).p(10).box.roundedFull.color(
                      configCtrl.bottomBarIndex.value == 2
                        ? AppConst.green.withOpacity(0.5)
                        : Colors.white
                    ).make().onInkTap(() => configCtrl.bottomBarIndex.value = 2),

                    const Icon(Entypo.user, color: Vx.gray600).p(10).box.roundedFull.color(
                      configCtrl.bottomBarIndex.value == 3
                        ? AppConst.green.withOpacity(0.5)
                        : Colors.white
                    ).make().onInkTap(() => configCtrl.bottomBarIndex.value = 3)

                  ],
                ).p(5)
              ).white.withRounded(value: 60.0).make()
        );
      }
    );
  }

}
