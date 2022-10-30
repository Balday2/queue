import 'package:mc_scanner/Utils/constants.dart';
import 'package:mc_scanner/Utils/helpers.dart';
import 'package:mc_scanner/controller/scan.controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


final carnetCtrl = Get.find<ScanController>();
class CarnetHttp {


  static Future<List> controlePassport(String idPassport) async {
      var response = await http.get(
        Uri.parse("${MyCst.URL}/passport/scan/$idPassport"), 
        headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${carnetCtrl.userToken.value}'
          },
      ).timeout(
        const Duration(seconds: 50), 
        onTimeout: () => http.Response('Error', 409)
      ); 

    
    if(Helpers.isJsonParsable(response.body)){
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
          return [data, "", 200];
      } 
      else {
        if(response.statusCode == 401) {
          return ['', 'Votre session a expirée, veillez-vous reconnecter', 401];
        }
        else if(response.statusCode == 409) {
          return ['', "Une erreur de connexion s'est produite", 409];
        }
        var error = jsonDecode(response.body);
        if(error != null && error['error'] != null) {
          return ['', error['error'], response.statusCode];
        }
        return ['', 'une erreur inconnue s\'est produite', 403];
      }
        
    }
    return ['', 'Votre session a expirée, veillez-vous reconnecter', 401];
  }


  static Future<List> quantity(String qtity) 
  async {
    var response = await http.get(
        Uri.parse("${MyCst.URL}/passport/scan/$qtity"), 
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${carnetCtrl.userToken.value}'
        },
      ).timeout(const Duration(seconds: 30));

    if(Helpers.isJsonParsable(response.body)){
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
          return [data, "", 200];
      } 
      else {
        if(response.statusCode == 401) {
          return ['', 'Votre session a expirée, veillez-vous reconnecter', 401];
        }
        else if(response.statusCode == 409) {
          return ['', "Une erreur de connexion s'est produite", 409];
        }
        var error = jsonDecode(response.body);
        if(error != null && error['error'] != null) {
          return ['', error['error'], response.statusCode];
        }
        return ['', 'une erreur inconnue s\'est produite', 403];
      }
        
    }
    return ['', 'Votre session a expirée, veillez-vous reconnecter', 401];
  }

}
