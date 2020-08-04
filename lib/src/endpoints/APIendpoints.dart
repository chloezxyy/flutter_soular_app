import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIEndpoints {

   Future<http.Response> attemptSell(String amtInput) async {
       final SharedPreferences prefs = await SharedPreferences.getInstance();
    var _amtInputController;
        String amtInput = _amtInputController.text;
    print('amt input:');
    print(amtInput);
    var token = prefs.getString('token');

    var url = "https://soular-microservices.azurewebsites.net/api/sell";

    final http.Response res = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          'amount': amtInput,
        }));
    print(res.statusCode);
    print(res.body);
    return res;
  }

}