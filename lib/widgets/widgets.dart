import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/controllers/config.controller.dart';
import 'package:velocity_x/velocity_x.dart';

class WidgetUi {

  /// button ui design
  Widget button(
      {required Widget child,
      double elevation = 0.0,
      outlineColor = Colors.transparent,
      isLoading = false,
      onPressed,
      shape = 0.0,
      Color shadow = Colors.transparent,
      Color color = Colors.blue,
      Color overColor = Colors.black,
      double width = 200.0,
      double height = 60.0}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 200),
          enableFeedback: true,
          backgroundColor: MaterialStateProperty.all(color),
          elevation: MaterialStateProperty.all(elevation),
          minimumSize: MaterialStateProperty.all(Size(width, height)),
          overlayColor: MaterialStateProperty.all(overColor.withOpacity(0.3)),
          shadowColor: MaterialStateProperty.all(shadow),
          visualDensity: VisualDensity.comfortable,
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(shape),
            side: BorderSide(width: 1.0, color: outlineColor),
          )),
        ),
        child: isLoading ? circularProgress() : child);
  }


    SizedBox circularProgress({tick = 2.0, color = Colors.white, size = 25.0}) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
          strokeWidth: tick, valueColor: AlwaysStoppedAnimation<Color>(color)),
    );
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
              ).white.withRounded(value: 60.0).border().make()
        );
      }
    );
  }
}