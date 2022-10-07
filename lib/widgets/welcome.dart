import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.asset.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/views/auth/phone_number.view.dart';
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
                    ),
                    10.heightBox,
                    "Queue".text.xl4.tighter.size(25.0).gray600.make()
                  ],
                ),
          ),


          [
            "🎉 Welcome !".text.size(20.0).white.make(),
            5.widthBox,
            const Icon(Icons.arrow_forward_sharp, color: Vx.white, size: 30.0,)
          ].hStack()
            .pSymmetric(h: 30,v: 15).box.color(AppConst.green).withRounded(value: 50.0)
            .make().onInkTap(() async {
              Get.to(() => const PhoneNumberView());
            }
          )
        ],
      ),
    );
  }
}