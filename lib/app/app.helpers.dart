

import 'package:get_storage/get_storage.dart';

class AppHelper {
  
  /// input validator with regex pattern
  static dynamic validator(String value, RegExp regex, [String? error]) {
    var v = value.toString().trim();
    if (v.isEmpty) {
      return 'Le champ est obligatoire';
    } else if (!regex.hasMatch(v)) {
      if (error != null) {
        return error;
      }
      return 'Veillez entrer une valeur valide';
    }
    return null;
  }

  static String getToken() {
    final box = GetStorage();
    final token = box.read('token');
    if (token != null && token != "") {
      return token;
    }
    return "";
  }
}