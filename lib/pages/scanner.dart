import 'dart:io';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mc_scanner/pages/scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_scanner/Utils/constants.dart';
import 'package:mc_scanner/Utils/widgets.dart';
import 'package:mc_scanner/controller/scan.controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:velocity_x/velocity_x.dart';


MyWidgets my = MyWidgets();



class Scanner extends StatefulWidget {
  const Scanner({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final GlobalKey<State> keyLoader = GlobalKey<State>();

  final cCtrl = Get.find<ScanController>();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Stack(
        children: <Widget>[

          _buildQrView(context),

          Align(
            alignment: Alignment.topLeft,
            child: const Icon(Feather.arrow_left, color: Vx.white, size:30.0).onInkTap(() {
              Get.back();
            })
          ).pOnly(top:50.0, left:20),


          Align(
            alignment: Alignment.topCenter,
             child:const Text(MyCst.qrMessage).text.white.center.make(),
          ).pOnly(top:80.0),


          

        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 20,
          // borderLength: 30,
          borderWidth: 15,
          cutOutSize: scanArea,
        ),
    );
  }

  void resumeCamera() async {
    Get.back();
    await controller!.resumeCamera();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      print("\n\n\n\n\n\nlisten.... ${result!.code} ");
      if(result != null){
        Get.to(() => ScannerView(qrCode: result!.code));
      }else{
        Get.back();
      }
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
