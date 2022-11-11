import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.asset.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAsset.search, height: Get.width/2),
            10.heightBox,
            "Trouver un service de votre choix".text.base.semiBold.gray600.center.fontFamily('Nunito').make(),
          ],
        ),
      ),
    );
  }
}