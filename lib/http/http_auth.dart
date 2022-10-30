import 'package:http/http.dart' as http;
import 'dart:convert';


class HttpASignin {


  static Future<List> signin(String email, String password) async {
    var response = await http.post(
      Uri.parse("https://bankitruck.com:5202/users/login"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body:jsonEncode(<String, String>{
          "email": email,
          "password":password, 
        }
      ),
    ).timeout(
      const Duration(seconds: 30)
    );
    if (response.statusCode == 200) {
      if(response.body == 'false'){
        return ["", "erreur email ou mot de passe incorrect !!!"];
      } else {
        var json = jsonDecode(response.body);
        return [json['token'], ""];
      }
    } else {
      return ["", "une erreur inconnue est survenue !!!"];
    }
  }


}
