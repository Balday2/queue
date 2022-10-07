import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/views/home/home.view.dart';
import 'package:velocity_x/velocity_x.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {

  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Vx.gray100,
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      backgroundColor: Vx.gray100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: "Entrer le code OTP réçu \npar message".text.xl3
              .bold.center.gray600.makeCentered().pSymmetric(h: 20)
          ),
          Column(
            children: [
              Container(
                height: 50.0,
                width: Get.width/1.2,
                color: Vx.gray300,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      letterSpacing: 7.0,
                      fontSize: 20.0,
                      height: 1.3
                    ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "......",
                    hintStyle: TextStyle(
                      letterSpacing: 7.0,
                      fontSize: 40.0,
                    )
                  ),
                  onChanged: (value){
                    setState(() {
                      phoneNumber = value;
                    });
                    print(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Center(
                  child: Column(
                    children: [
                      'Vous n\'avez pas réçu le code'.text.base.semiBold.gray600.fontFamily('Nunito').size(16).makeCentered(),
                      'Cliquez ici pour renvoyer '.text.base.semiBold.fontFamily('Nunito').size(16).color(AppConst.blue).underline.makeCentered(),
                    ],
                  ),
                ),
              )
            ],
          ),
          [
            "Terminé".text.size(20.0).white.make(),
            10.widthBox,
            const Icon(Icons.check, color: Vx.white, size: 30.0,)
          ].hStack()
            .pSymmetric(h: 30,v: 15).box.color(AppConst.green).withRounded(value: 50.0)
            .make().onInkTap(() async {
              Get.to(() => const HomeView());
            })
        ],
      ),
    );
  }
}