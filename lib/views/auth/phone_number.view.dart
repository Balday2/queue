import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/views/auth/otp.view.dart';
import 'package:velocity_x/velocity_x.dart';

class PhoneNumberView extends StatefulWidget {
  const PhoneNumberView({super.key});

  @override
  State<PhoneNumberView> createState() => _PhoneNumberViewState();
}

class _PhoneNumberViewState extends State<PhoneNumberView> {

  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Vx.gray100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: "Juste votre numéro de téléphone pour vous inscrire ou vous connecter".text.xl3
              .center.gray600.makeCentered().p(20)
          ),
          Column(
            children: [
              Container(
                height: 50.0,
                width: Get.width/1.2,
                color: Vx.gray300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: "+224".text.base.bold.gray600.make()
                    ),
                    "|".text.size(25.0).gray500.make().pSymmetric(h: 10),
                  
                    Expanded(
                      child: TextField(
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 15.0,
                              height: 1.3
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Numéro de téléphone",
                            ),
                            onChanged: (value){
                              setState(() {
                                phoneNumber = value;
                              });
                              print(value);
                            },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Center(
                  child: Column(
                    children: [
                      'En renseignant votre numéro de téléphone'.text.base.semiBold.gray600.fontFamily('Nunito').makeCentered(),
                      [
                        'vous acceptez nos '.text.base.semiBold.gray600.fontFamily('Nunito').makeCentered(),
                        'Conditions d\'utilisations '.text.base.semiBold.fontFamily('Nunito').color(AppConst.blue).underline.makeCentered(),
                      ].hStack(),

                      [
                        'et notre '.text.base.semiBold.gray600.fontFamily('Nunito').makeCentered(),
                        'Politique de confidentialité. '.text.base.semiBold.fontFamily('Nunito').color(AppConst.blue).underline.makeCentered(),
                      ].hStack(),
                      'Merc !'.text.base.semiBold.gray600.fontFamily('Nunito').makeCentered(),
                    ],
                  ),
                ),
              )
            ],
          ),
          [
            "Suivant".text.size(20.0).white.make(),
            10.widthBox,
            const Icon(Icons.arrow_forward_sharp, color: Vx.white, size: 30.0,)
          ].hStack()
            .pSymmetric(h: 30,v: 15).box.color(AppConst.green).withRounded(value: 50.0)
            .make().onInkTap(() async {
              Get.to(() => const OtpView());
            })
        ],
      ),
    );
  }
}