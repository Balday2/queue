import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MatrixRepository {

  static Future<List> matrix({required Position c1, required Position c2 , required String apiKey}) async {

    var resp = 
    await http.get(
      Uri.parse("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${c1.latitude},${c1.longitude}&destinations=${c2.latitude},${c2.longitude}&key=$apiKey")
    );

    if(resp.statusCode == 200){
      var matrix = json.decode(resp.body);
      var data = matrix['rows'][0]['elements'][0];
      double km = data['distance']['value']/1000;
      var time = data['duration']['text'];

      return [km, time];
    }
    else {
      return ['error'];
    }
  } 
}
