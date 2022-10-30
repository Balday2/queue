import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/app/app.helpers.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/app/config/app.regex.dart';
import 'package:queue/controllers/auth.controller.dart';
import 'package:queue/views/auth/auth.widget.dart';
import 'package:queue/widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class PhoneNumberView extends StatefulWidget {
  const PhoneNumberView({super.key});

  @override
  State<PhoneNumberView> createState() => _PhoneNumberViewState();
}

class _PhoneNumberViewState extends State<PhoneNumberView> {
  final ui = WidgetUi();
  final authCtrl = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final phone = TextEditingController();



  Future<dynamic> submit() async {
      FocusScope.of(context).requestFocus(FocusNode());
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();
        await authCtrl.verifyPhone("+224${phone.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Vx.gray100,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: "Juste votre numéro de téléphone pour vous inscrire ou vous connecter".text.xl3
                .center.gray600.makeCentered().p(20)
            ),
            Column(
              children: [
                
                SizedBox(
                  width: Get.width/1.2,
                  child: Form(
                    key: _formKey,
                    child: AuthWidget().inputForm(
                      "Numero de téléphone", 
                      nextInput: TextInputAction.next, 
                      validate: (v) => validator(v!, phonePattern),
                      controller: phone, 
                      onChange:(_) {},
                      iconL: [
                        10.widthBox,
                        SizedBox(
                          width: 40,
                          child: "+224".text.base.bold.gray600.make()
                        ),
                        "|".text.size(25.0).gray500.make().pSymmetric(h: 10)
                      ].hStack(),
                      type: TextInputType.number,
                    ),
                  ),
                ),
                20.heightBox,
                
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
      
            Obx(() {
                return ui.button(
                  child: [
                    "Suivant".text.size(20.0).white.make(),
                    10.widthBox,
                    const Icon(Icons.arrow_forward_sharp, color: Vx.white, size: 30.0,)
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
      ),
    );
  }
}