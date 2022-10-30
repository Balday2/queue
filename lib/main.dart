
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mc_scanner/Utils/app_bindings.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mc_scanner/Utils/splash.view.dart';
import 'package:mc_scanner/pages/login.dart';



class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFFFFFF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashView(),
          binding: AppBinding(),
        )
      ],
    );
  }
}


