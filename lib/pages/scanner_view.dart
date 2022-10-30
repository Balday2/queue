import 'package:mc_scanner/Utils/widgets.dart';
import 'package:mc_scanner/controller/scan.controller.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';


final scanCtrl = Get.find<ScanController>();
MyWidgets my = MyWidgets(); 

class ScannerView extends StatefulWidget {
  final qrCode;
  const ScannerView({Key? key, this.qrCode}) : super(key: key);

  @override
  _ScannerViewState createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {

  @override
  void initState() { 
    super.initState();
    scanCtrl.controlePassport(context, widget.qrCode.toString(), loading: false);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero, 
      (){
        if(widget.qrCode != null) {
          my.scaningUi(context, true);
        } else {
          print("rien.........");
        }
      }
    );
    return Scaffold(
      backgroundColor: Vx.black,
      body: widget.qrCode != null
        ? Center(
          child: VxBox(
              child:my.scaningUi(context, true)
            ).rounded.size(Get.width/1.5, Get.width/1.2).white.make()
          ) 
        : const Center()
    );
  }
}