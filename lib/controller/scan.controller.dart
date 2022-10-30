import 'package:get_storage/get_storage.dart';
import 'package:mc_scanner/Utils/widgets.dart';
import 'package:mc_scanner/http/http_auth.dart';
import 'package:mc_scanner/http/http_carnet.dart';
import 'package:mc_scanner/models/model_carnet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mc_scanner/pages/login.dart';
import 'package:velocity_x/velocity_x.dart';


class UtilsModel {
  String status; 

  /// disable or enable button
  bool showBtn;
  UtilsModel({required this.status, required this.showBtn });
}



class ScanController extends GetxController {

  var isLoading = false.obs;
  var status = 0.obs;
  var always = true.obs;
  var error = "".obs;

  /// if step == 0 [scanning or response] otherwise quantity input
  var step = 0.obs;
  var scanSuccess = [].obs;
  var userToken = "".obs;
  MyWidgets my = MyWidgets();
  final GlobalKey<State> keyLoader = GlobalKey<State>();
  RxList<CarnetModel> cm = <CarnetModel>[].obs;





  final utModel = UtilsModel(status: "on", showBtn: false).obs;

  updateToken(var v){
    userToken.value = v;
    update();
  }





  Future<String> signin(String email, String pwd) async {
      error.value = "";
      try {
        isLoading(true);
        var user = await HttpASignin.signin(email, pwd);
        error.value = user[1];
        if(user[0] != ""){
          userToken.value = user[0];
          await GetStorage().write('token', user[0]);
        }
        else {
          error.value = user[1];
        }

      }on Error {
        error.value = error.value != "" ? error.value : "Une erreur de connexion c'est produit !!!";
      }
      finally {
        isLoading(false);
        Get.back();
      }
      return error.value;
  }


  quantity(ctx, String quantity) async {
      isLoading(true);
      error.value = ''; 
      status.value = 100;
      try {
        var data = await CarnetHttp.quantity(quantity);
        if(data.isNotEmpty && data[2] == 200){
          status.value = data[2];
          error.value = 'success';
        }
        else if(data[2] == 401) {
          Get.offAll(() => Login());
          VxToast.show(ctx, msg:data[1], bgColor: Vx.red500);
        }
        else{
          error.value = data[1];
          status.value = data[2];
        }
      } catch (e) {
        error.value = e.toString();
        status.value = 403;
      } finally {
        isLoading(false);
        step.value = 0;
      }
  }


  controlePassport(ctx,idPassport, {loading = false}) async {
    error.value = ''; 
    status.value = 100;
    step.value = 0;
    try {
      if(loading){
        my.dialogUi(
          child: VxBox(
            child: my.scaningUi(ctx, false)
          ).rounded.size(Get.width/1.5, Get.width/1.2).white.make()
        );
      }
      var data = await CarnetHttp.controlePassport(idPassport); 

      
      if(data.isNotEmpty && data[2] == 200){
        /// si step egal a [1] entrez la quantite du litre
        step.value = 1;
        scanSuccess.clear();
        scanSuccess.add(data[0]);
        status.value = data[2];
        error.value = 'success';
      }
      else if(data[2] == 401) {
        Get.offAll(() => Login());
        VxToast.show(ctx, msg:data[1], bgColor: Vx.red500);
      }
      else{
        error.value = data[1];
        status.value = data[2];
      }
    } catch (e) {
      error.value = e.toString();
      status.value = 403;
    } finally {
        step.value = 1;
    }
  }


}