import 'package:mc_scanner/Utils/helpers.dart';
import 'package:mc_scanner/Utils/widgets.dart';
import 'package:mc_scanner/controller/scan.controller.dart';
import 'package:mc_scanner/http/http_carnet.dart';
import 'package:mc_scanner/pages/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';


MyWidgets my = MyWidgets();

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  
  bool showPwd = true;

  // final authCtrl = Get.find<UserController>();
  final email = TextEditingController();
  final password = TextEditingController();



  Future<dynamic> _submit(BuildContext context) async{
    Helpers.checkConnection(context, 
      () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final carnetCtrl = Get.find<ScanController>();

        if (!_formKey.currentState!.validate()) return;
        _formKey.currentState!.save();

        String error = await carnetCtrl.signin(email.text, password.text);
        if (error != "") {
          Get.snackbar("Erreur", error.toString());
        } else {
          Get.off(() => const Welcome(),popGesture: true,duration:1.seconds);
        }
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Vx.gray300, 
      body: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width/6),
              Image.asset('assets/logo.png', width: MediaQuery.of(context).size.width/1.5, fit: BoxFit.contain).pSymmetric(v:50),
              20.heightBox,
              Align(
                alignment: Alignment.topLeft,
                child:[
                  'Bienvenue sur MC Scanner'.text.xl2.black.make(),
                  'Veillez-vous connectez pour pouvoir\nscanner les cartes de vos consommateurs'.text.gray700.start.medium.fontWeight(FontWeight.w400).make(),
                  20.heightBox,
                ].vStack(crossAlignment: CrossAxisAlignment.start)
              ),
              form(context).pSymmetric(h:10, v:10), 
              Obx(() => my.button(
                  child: "Se connecter".text.white.xl2.make(), 
                  width: MediaQuery.of(context).size.width, 
                  overColor: Vx.white, 
                  shape: 5.0, 
                  isLoading: carnetCtrl.isLoading.value,
                  onPressed: (){
                    _submit(context);
                  }
                ).pSymmetric(v: 20),
              ),
              20.heightBox, 
            ],
          ).p(15).scrollVertical()
    );
  }



  Widget form(context) {
    return Form(
      key: _formKey, 
      child: Column(
        children: [
          my.inputForm2(
            context,
            labelText: "Votre email",
            nextInput: TextInputAction.next,
            kbType: TextInputType.emailAddress,
            controller: email,
            onChanged: (v) {},
            validate: (v) {
              if (v == null || v.isEmpty) {
                return "Erreur ce champ est réquis";
              }
            },
          ),
          20.heightBox,
          my.inputForm2(
            context,
            labelText: "Votre mot de passe",
            nextInput: TextInputAction.done,
            rightIcon: IconButton(
              onPressed: () => setState(() { showPwd = !showPwd;}),
              icon: Icon(showPwd ? Icons.visibility_off : Icons.visibility)
            ),
            showText: showPwd,
            controller: password,
            onChanged: (v) {},
            validate: (v) {
              if (v == null || v.isEmpty) {
                return "Erreur ce champ est réquis";
              }
            },
          ),
        ],
      ),
    ); 
  }
}