import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/app/app.helpers.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/app/config/app.regex.dart';
import 'package:queue/controllers/auth.controller.dart';
import 'package:queue/views/auth/auth.widget.dart';
import 'package:queue/widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final authCtrl = Get.find<AuthController>();
  final ui = WidgetUi();

  final _formKey = GlobalKey<FormState>();
  final otp = TextEditingController();

  Future<dynamic> submit() async {
      FocusScope.of(context).requestFocus(FocusNode());
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();
        await authCtrl.verifyOtp(otp.text);
  }
  
  String otpInput = "";
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

              SizedBox(
                  width: Get.width/1.2,
                  child: Form(
                    key: _formKey,
                    child: AuthWidget().inputForm(
                      "●●●●●●", 
                      textAlign: TextAlign.center,
                      letterSpacing: 7.0,
                      nextInput: TextInputAction.next, 
                      validate: (v) => validator(v!, otpPattern),
                      controller: otp, 
                      onChange:(_) {},
                      type: TextInputType.number,
                    ),
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

          Obx(() {
              return ui.button(
                child: [
                  "Terminé".text.size(20.0).white.make(),
                  10.widthBox,
                  const Icon(Icons.check, color: Vx.white, size: 30.0,)
                ].hStack().pSymmetric(h: 10),
                color: AppConst.green,
                overColor: Colors.white,
                isLoading: authCtrl.loading.value,
                height: 70.0,
                shape: 60.0,
                onPressed: submit
              );
            }
          )
        ],
      ),
    );
  }
}