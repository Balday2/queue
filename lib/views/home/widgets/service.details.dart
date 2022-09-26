import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.asset.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/models/marker.model.dart';
import 'package:queue/widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class ServiceDetails extends StatelessWidget {
  final MarkerModel marker;
  const ServiceDetails({super.key, required this.marker});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: VxBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        AppAsset.icon,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(marker.title.toString()),
                          const Text("Description de Jhon doe"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
           
              WidgetUi().button(
                child: "CALL".text.white.size(20.0).xl2.make(), 
                width: Get.width, 
                bColor:  AppConst.green,
                overColor: Vx.white, 
                shape: 20.0, 
                onPressed: null
              )
            ],
          ),
        ),
      ).roundedLg.white.make()
    );
  }
}