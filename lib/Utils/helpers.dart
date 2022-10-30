import 'dart:convert';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mc_scanner/Utils/colors.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_scanner/Utils/widgets.dart';
// import 'package:mc_scanner/controller/scan.controller.dart';
import 'package:velocity_x/velocity_x.dart';
MyWidgets my = MyWidgets();


class Helpers {


  /// check if user has a connection 
  static checkConnection(context, Function() callback) async {
    // final carnetCtrl = Get.find<ScanController>();
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      // carnetCtrl.updateUtils(status: "off");
      // carnetCtrl.updateStatus("off");
      Helpers.snackBar(
        title: 'Infos', 
        msg: "vous n'êtes pas connecté !!!", 
        icon: const Icon(Feather.info, color:Vx.white),
      );
    } else if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      // carnetCtrl.updateUtils(status: "on");
      callback();
    } else {
      // carnetCtrl.updateUtils(status: "off");
      // carnetCtrl.updateStatus("off");
       Helpers.snackBar(
        title: 'Infos', 
        msg: "vous n'êtes pas connecté !!!", 
        icon: const Icon(Feather.info, color:Vx.white),
      );
    }
  }




  static snackBar({
    title ='Infos', msg ='', int time =3, bColor =Vx.black, Widget? icon, 
    color =Vx.white, SnackPosition position = SnackPosition.BOTTOM, Widget? widget
  }) {
    Get.showSnackbar(
      GetSnackBar(
          title: title,
          duration: Duration(seconds: time),
          backgroundColor: bColor, 
          icon: icon, 
          snackPosition: position, 
          messageText: msg.toString().text.color(color).make(),
          mainButton: widget
      ),
    );
  }

    static isJsonParsable (string) {
    try {
        jsonDecode(string);
    } catch (e) {
        return false;
    }
    return true;
  }

  static toast(msg,{data = "", position =SnackPosition.BOTTOM, time =3, Widget? widget}){
    if(data != ""){
      Helpers.snackBar(
        title: 'Success', 
        msg: msg, 
        position: position,
        time: time,
        bColor: Colors.green[200],
        icon: const Icon(Feather.check_circle, color:Vx.white),
        widget: widget
      );
    } else {
        Helpers.snackBar(
        title: 'Erreur', 
        time: time,
        msg: msg, 
        position: position,
        bColor: Vx.red500,
        icon: const Icon(Icons.close, color:Vx.white),
        widget: widget
      );
    }
  }





}