
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mc_scanner/Utils/assets.dart';
import 'package:mc_scanner/Utils/colors.dart';
import 'package:mc_scanner/Utils/helpers.dart';
import 'package:mc_scanner/controller/scan.controller.dart';
import 'package:mc_scanner/pages/scanner.dart';
import 'package:mc_scanner/pages/welcome/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mc_scanner/Utils/widgets.dart';
import 'package:velocity_x/velocity_x.dart';


MyWidgets my = MyWidgets();
final cCtrl = Get.find<ScanController>();

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

    final _formKey = GlobalKey<FormState>();
    Map<String, String> data = {'idPassport': ''};


    Future<dynamic> _submit(BuildContext context) async{
      Helpers.checkConnection(context, 
        () async {
          FocusScope.of(context).requestFocus(FocusNode());

          if (!_formKey.currentState!.validate()) return;
          _formKey.currentState!.save();
          Get.back(); // close bottomsheet 
          await cCtrl.controlePassport(
            context, 
            data['idPassport'], 
            loading: true
          );
        }
      );
    }


    void input(){
     my.bottomSheet(context, child: [
        5.heightBox,
        VxBox().withRounded(value: 10).gray300.size(40.0, 5.0).make(),
        5.heightBox,
        Align(
          alignment: Alignment.topLeft,
          child: "ID Carte".text.black.bold.xl.make()
        ), 
        10.heightBox,
        "Point du contrôle de la carte, entrez l'ID du client pour lancer la vérification.".text.black.make(),
        5.heightBox, 
        Center(
          child: Form(
            key: _formKey,
            child: my.inputForm(
              "ID Carte", 
              valide: (value){
                if(value.isEmpty) return "\u26A0 Le champ est obligatoire.";
                return null;
              },
              save:(value) {data['idPassport'] = value;},
              change: (value){},
            )
          )
        ).pSymmetric(v:10), 
        my.buttonUI(
            child: "Verifier".tr.text.white.xl2.make(), 
            width: Get.width, 
            overColor: Vx.white, 
            shape: 5.0, 
            onPressed: (){ _submit(context); }
          ),
          20.heightBox,
        ].vStack().pSymmetric(h:10)
      );
    }


    
    void logout(){
     my.bottomSheet(context, child: [
        5.heightBox,
        VxBox().withRounded(value: 10).gray300.size(40.0, 5.0).make(),
        5.heightBox,
        Align(
          alignment: Alignment.topLeft,
          child: "Déconnexion".text.black.bold.xl.make()
        ), 
        10.heightBox,
        Align(
          alignment:Alignment.topLeft,
          child: "Vous êtes sur point de vous déconnecter de l'application\nVoulez-vous vraiment quité?".text.black.make()
        ),
        10.heightBox, 

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: [
            my.buttonUI(
              child: "Quitter".tr.text.white.xl2.make(), 
              width: Get.width/3, 
              color:  MyColors.kRed,
              overColor: Vx.white, 
              shape: 5.0, 
              onPressed:() async {
                SystemNavigator.pop();
              }, 
            ).pOnly(right: 10),

            my.buttonUI(
              child: "Non".tr.text.white.xl2.make(), 
              width: Get.width/3, 
              overColor: Vx.white, 
              shape: 5.0, 
              onPressed: (){ Get.back(); }
            ).pOnly(right: 10),
          ],
        ),
        10.heightBox, 
       
      ].vStack().pSymmetric(h:10)
     );
    }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.flou1,
      appBar: AppBar(
        backgroundColor: MyColors.flou1,
        leading: Image.asset(AppAsset.logo).pOnly(left: 5.0),
        title:  "MC Scanner".text.black.bold.xl2.make(),
        actions: [
          IconButton(
            onPressed: () => logout(),
            icon: const Icon(Feather.log_out, color: Vx.black),
          )
        ],
        elevation: 10.0,
      ),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ 
          Container(
            child:[
             carnetCard(),
             20.heightBox, 
             Align(
               alignment: Alignment.topLeft,
               child:  "Contrôle de la carte".text.black.bold.xl.make()
             ).p(5),
             VxBox(
               child: [[
                 Expanded(
                   flex: 1,
                   child:"Point du contrôle de la carte, scannez le Qrcode du client pour lancer la vérification."
                        .text.black.medium.shadowBlur(0.3).size(15).make()
                 ), 
                 Image.asset(AppAsset.qrcode, width:120.0, height: 120.0, fit:BoxFit.fill), 
               ].hStack(),
              10.heightBox,
               Align(
                alignment: Alignment.topRight,
                 child: [
                  "clickez".text.underline.black.base.make(),
                   const Icon(Icons.arrow_forward_sharp)
                ].hStack(),
               )
               ].vStack().p(15).onInkTap(() {Get.to(() => const Scanner());}),
             ).width(Get.width).amber600.shadow.roundedSM
              .make().pSymmetric(v: 10),
             10.heightBox,

              VxBox(
               child: [[
                 Image.asset(AppAsset.code,width:120.0, height: 120.0, fit:BoxFit.contain),
                 10.widthBox, 
                 Expanded(
                   flex: 1,
                   child:"Point du contrôle de la carte, entrez l'ID du client pour lancer la vérification."
                        .text.black.medium.shadowBlur(0.3).size(15).make()
                 ), 
               ].hStack(),
               10.heightBox,
                Align(
                  alignment: Alignment.topRight,
                  child: [
                    "clickez".text.underline.black.base.make(),
                    const Icon(Icons.arrow_forward_sharp)
                  ].hStack(),
                )
              ].vStack().p(15).onInkTap(() {
                  input();
                })
              ).width(Get.width).red600.shadow.roundedSM.make().pSymmetric(v: 10),


            ].vStack().scrollVertical(), 
          ), 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAsset.logo, 
                fit:BoxFit.contain, 
                height: 55.0,
                width: 55.0,
              ),
              5.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Contrôle de la carte").text.lg.black.semiBold.make(),
                  const Text("Developed by Banki Technology").text.base.size(12.0).black.make(),
                ],
              )
            ],
          )
        ],
      ).p(10)
    );
  }


}