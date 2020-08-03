import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_soular_app/src/pages/home_page.dart';
import 'package:flutter_soular_app/src/pages/main_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class WalletPage extends StatefulWidget {
  WalletPage({Key key}) : super(key: key);
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  SharedPreferences sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _redeemCodeController = TextEditingController();
  double width;
  
  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      // borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 80,
          width: width,
          decoration: BoxDecoration(
            color: Colors.blue[200],
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circularContainer(300, Colors.blue[200])),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circularContainer(width * .5, Colors.blue[200])),
              Positioned(
                  top: -230,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 30,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })),
                          Container(
                              padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Your Wallet",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ]))
                        ],
                      ))),
            ],
          )),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

    Future<http.Response> attemptRedeemCode(
      String redeemCode) async {
    String redeemCode = _redeemCodeController.text;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
     var token = prefs.getString('token');
    print('redeem code input:');
    print(redeemCode);

    var url =
        "https://soular-microservices.azurewebsites.net/api/topup";

    final http.Response res = await http.post(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
          'redeemCode': redeemCode
        }));
    print(res.statusCode);
    print(res.body);
    return res;
  }

  Widget _redeemCodeField() {
    return Container(
        padding: EdgeInsets.all(20.0),
        width: 250,
        child: Column(children: <Widget>[
                    Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: Text("Enter Redeemption Code",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ),
          Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        // validator: amtValidator(_inpPrice),
                        validator: (value) {
                          var priceInt = double.parse(value);

                          if (value.isEmpty) {
                            return 'Please enter text';
                          }
                          if (priceInt < 0.001) {
                            return 'Invalid amount';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          print(text);
                        },
                        textAlign: TextAlign.center,
                        controller: _redeemCodeController,
                                                
                        ),
                  ]))
        ]));
  }
    void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      child: Column(children: <Widget>[
        _header(context),
        SizedBox(height: 20),
        _redeemCodeField(),
        RaisedButton(
          textColor: Colors.white,
          color: Colors.green,
          child: Text("Submit"),
          onPressed: () async {
            sharedPreferences = await SharedPreferences.getInstance();
            var redeemCode = _redeemCodeController.text;
            var res = await attemptRedeemCode(redeemCode);
            print('this code:');
            print(redeemCode);
            if (res.statusCode == 200) {
              displayDialog(context, "Success", "Code has been redeemed.");

            } else if (res.statusCode == 400) {
              print(res.headers);
              displayDialog(
                  context, "400", "Bad input parameter");
            } else if (res.statusCode == 401) {
               print("401");
               String redeemCode = _redeemCodeController.text;
                    // get new refresh token
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var refreshtoken =
                        prefs.getString('refreshtoken'); // refresh token
                    var token = prefs.getString('token');
                    print('YO');
                    print(token);
                    var url =
                        "https://soular-microservices.azurewebsites.net/api/refresh_token";

                    final http.Response res = await http.post(url,
                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{
                          'refreshToken': refreshtoken,
                        }));

                    // set new access token
                    var jsonData = null;
                    jsonData = json.decode(res.body);
                    print('jsondata');
                    print(jsonData);

                    sharedPreferences.setString(
                        "token", jsonData["accessToken"]);

                    print('attempt to purchase again');
                    attemptRedeemCode(redeemCode);

                    // displayDialog(context, "Unauthorized purchase", "401");

              displayDialog(context, "Unauthorized", "401");
            } else if (res.statusCode == 403) {
              print(res.headers);
              displayDialog(context, "Redeemption code error", "- 403");
            } else {
              print(res.headers);
              displayDialog(context, "Error", "An unknown error occurred.");
            }
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        )
      ]),
    )));
  }
}
