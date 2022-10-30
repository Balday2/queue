import 'package:get/get.dart';
import 'package:mc_scanner/Utils/assets.dart';
import 'package:mc_scanner/controller/scan.controller.dart';


class AppBinding extends Bindings {

  @override
    void dependencies() {
      Get.put(ScanController(), permanent: true);
      Get.put(AppAsset(), permanent: true);

    }
}
