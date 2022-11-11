import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.asset.dart';
import 'package:velocity_x/velocity_x.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAsset.history, height: Get.width/2),
            10.heightBox,
            "Vous n'avez aucune historique\npour le moment".text.base.semiBold.center.gray600.fontFamily('Nunito').make(),
          ],
        ),
      ),
    );
  }
}