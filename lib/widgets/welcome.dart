import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.asset.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/views/home/home.view.dart';
import 'package:velocity_x/velocity_x.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Queue".text.xl4.bold.size(25.0).gray600.make()
                  ],
                ),
          ),
          [
            "🎉 Welcome !".text.xl2.size(20.0).bold.white.make(),
            const Icon(Icons.arrow_forward_sharp, color: Vx.white, size: 35.0,)
          ].hStack()
            .pSymmetric(h: 30,v: 15).box.color(AppConst.green).withRounded(value: 50.0)
            .make().onInkTap(() {
              Get.to(() => const HomeView());
            })
        ],
      ),
    );
  }
}