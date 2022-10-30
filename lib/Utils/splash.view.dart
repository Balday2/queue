import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mc_scanner/Utils/assets.dart';
import 'package:mc_scanner/Utils/constants.dart';
import 'package:mc_scanner/pages/login.dart';
import 'package:mc_scanner/pages/welcome/welcome.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      checkToken();
    });
  }

  checkToken() async {
    var token = await GetStorage().read('token');
    if(token != "" && token != null){
      Get.to(() => const Welcome());
    } else {
      Get.to(() => Login());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAsset.logo),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: LinearProgressIndicator(
                  color: MyCst.red,
                  backgroundColor: MyCst.black,
                ),
              )
            ],
          )
        ),
    );
  }
}