
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.asset.dart';
import 'package:queue/widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

final ui = WidgetUi(); 

class UserView extends StatelessWidget {
  UserView({Key? key}) : super(key: key);
  final ScrollController scrollCtrl = ScrollController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Vx.white,
      body: ListView(
          controller: scrollCtrl,
          children: [
            20.heightBox, 
            Align(
              alignment: Alignment.center, 
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      AppAsset.avatar, 
                      height:context.isTablet ? Get.width/5 :  Get.width/4,
                      width:context.isTablet ? Get.width/5 :  Get.width/4,
                      fit: BoxFit.cover
                    ),
                  ),
                  20.heightBox, 
                  "Mahmud Balde".text.xl.gray700.make(),
                ],
              ),
            ),
            20.heightBox,

            [
              const Icon(Icons.phone, color: Vx.white, size:20).p(5).box.withRounded(value:5.0).color(Vx.blue500.withOpacity(0.8)).make(),
              10.widthBox, 
              "+224 621078833".text.xl.bold.fontFamily('Nunito').make(),
            ].hStack().pSymmetric(v:10, h:Get.width/20), 

            [
              const Icon(Icons.mail, color: Vx.white,  size:20).p(5).box.withRounded(value:5.0).color(Vx.pink500.withOpacity(0.8)).make(),
              10.widthBox, 
              "mahmud.balday@gmail.com".text.xl.bold.fontFamily('Nunito').make(),
            ].hStack().pSymmetric(v:10, h:Get.width/20),
            const VxDivider().pSymmetric(v:10), 

            'Paramètre de l\'application'.text.xl.medium.fontFamily('Nunito').make().p(10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                [
                  const Icon(Feather.user, color: Vx.white,  size:20).p(5).box.withRounded(value:5.0).color(Vx.teal500.withOpacity(0.8)).make(),
                  10.widthBox, 
                  "Editer mon profile".text.xl.bold.fontFamily('Nunito').make(),
                ].hStack(),

                const Icon(Icons.chevron_right, color: Vx.gray500)
              ]
            ).pSymmetric(v:10, h:Get.width/20).onInkTap(() { }), 


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                [
                  const Icon(Icons.lock, color: Vx.white,  size:20).p(5).box.withRounded(value:5.0).color(Vx.red700.withOpacity(0.8)).make(),
                  10.widthBox, 
                  "Changer le Password".text.xl.bold.fontFamily('Nunito').make(),
                ].hStack(),

                const Icon(Icons.chevron_right, color: Vx.gray500)
              ]
            ).pSymmetric(v:10, h:Get.width/20).onInkTap(() { }),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                [
                  const Icon(Feather.log_out, color: Vx.white,  size:20).p(5).box.withRounded(value:5.0).color(Vx.red700.withOpacity(0.8)).make(),
                  10.widthBox, 
                  "Se déconnecter".text.xl.bold.fontFamily('Nunito').make(),
                ].hStack(),
                const Icon(Icons.chevron_right, color: Vx.gray500)
              ]
            ).pSymmetric(v:10, h:Get.width/20).onInkTap(() {}), 


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                [
                  const Icon(Icons.info_outline, color: Vx.white,  size:20).p(5).box.withRounded(value:5.0).color(Vx.orange500.withOpacity(0.8)).make(),
                  10.widthBox, 
                  "À propos".text.xl.bold.fontFamily('Nunito').make(),
                ].hStack(),
                const Icon(Icons.chevron_right, color: Vx.gray500)
              ]
            ).pSymmetric(v:10, h:Get.width/20), 
          ],
        )
    );
  }
}