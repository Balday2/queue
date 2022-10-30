
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_scanner/Utils/assets.dart';
import 'package:mc_scanner/Utils/widgets.dart';
import 'package:velocity_x/velocity_x.dart';


MyWidgets my = MyWidgets();


  Widget carnetCard(){
    return VxBox(
               child: [
                 Image.asset(AppAsset.logo, width: Get.width/2, fit:BoxFit.contain).pSymmetric(v:5),
                 "Le carburant de UTS à votre porté".text.lg.wider.bold.make(),
                Divider(color: Colors.red[900],thickness: 7.0), 
               ].vStack().pSymmetric(v:10)
             ).width(Get.width).white.roundedSM.make();
  }


  void bottomSheed(context,{
    required String body, 
    required String title, 
    required String img, 
    required Function click 
  }){
    my.bottomSheet(context, child: [
      5.heightBox,
      VxBox().withRounded(value: 10).gray300.size(40.0, 5.0).make(),
      5.heightBox,
      Align(
        alignment: Alignment.topLeft,
        child:  title.text.black.bold.xl.make()
      ), 
      10.heightBox,
      body.toString().text.black.make(),
      10.heightBox, 
        Flexible(
            child: VxBox(
              child: Center(
                child: [
                  Image.asset("assets/{$img}", width:Get.width/7, fit:BoxFit.contain), 
                  20.widthBox, 
                   title.text.black.bold.xl.make(),
                ].hStack(
                  crossAlignment: CrossAxisAlignment.center
                )
              ).pSymmetric(v:10)
            ).withRounded(value:10.0).indigo500.shadow.make().onInkTap(() {
              Get.back();
              click();
            })
          )
     ].vStack().pSymmetric(h:10)
    );
  }