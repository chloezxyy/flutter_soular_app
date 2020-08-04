import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// to convert raw Future<http.Response into a Dart object

class EnergyInfo {
  final double energyBalance;
  final double creditBalance;
  final double energyOnSaleBalance;
  final double currentPrice;

  EnergyInfo(
      {this.energyBalance,
      this.creditBalance,
      this.energyOnSaleBalance,
      this.currentPrice});

  factory EnergyInfo.fromJson(Map<String, dynamic> json) {
    return EnergyInfo(
      energyBalance: json['energyBalance'],
      creditBalance: json['creditBalance'],
      energyOnSaleBalance: json['energyOnSaleBalance'],
      currentPrice: json['currentPrice'],
    );
  }

  // function that fetches energy info from endpoint
  Future<EnergyInfo> getEnergyInfo() async {
    // ignore: avoid_init_to_null
    var json = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var res = await http.get(
      "https://soular-microservices.azurewebsites.net/api/energy_info",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      print(json);
      return EnergyInfo.fromJson(json.decode(res.body));
    }else{
      throw Exception('Failed to load /energy_info');
    }
  }
}
