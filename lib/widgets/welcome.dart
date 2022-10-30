import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.asset.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class WelcomeWidget extends StatelessWidget {
  WelcomeWidget({super.key});

  final ui = WidgetUi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Center(),
          Center(
            child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAsset.icon,
                      height: Get.width/2,
                      width: Get.width/2,
                    ),
                    10.heightBox,
                    "Queue".text.xl4.tighter.size(25.0).gray600.make()
                  ],
                ),
          ),

          ui.button(
            child: [
              "🎉 Welcome !".text.size(20.0).white.make(),
              5.widthBox,
              const Icon(Icons.arrow_forward_sharp, color: Vx.white, size: 30.0,)
            ].hStack().pSymmetric(h: 10),
            color: AppConst.green,
            overColor: Colors.white,
            isLoading: false,
            height: 70.0,
            shape: 60.0,
            onPressed: () => Get.toNamed('/phone')
          )
        ],
      ),
    );
  }
}