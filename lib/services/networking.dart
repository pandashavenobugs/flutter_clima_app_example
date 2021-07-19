import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class NetworkHelper {
  // final double? latitude;
  // final double? longitude;
  final Map<String, String>? queryParameters;
  final String? apiMainDomain;
  final String? apiRoute;

  NetworkHelper(
      {@required this.queryParameters,
      @required this.apiMainDomain,
      @required this.apiRoute});

  Future getData() async {
    final Uri uri = Uri.http(apiMainDomain!, apiRoute!, queryParameters!);
    // http.Response response = await http.get(Uri.parse(
    //     'http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=eaaf25748cbac49f3e98a5df996bb406'));

    // print(response.statusCode);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      // var longitude = jsonDecode(data)['weather'][0];
      // print(longitude);
      // print(response.statusCode);

      return jsonDecode(data);
    } else {
      throw 'error';
    }
  }
}
