import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_soular_app/src/pages/main_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BuyPage extends StatefulWidget {
  BuyPage({Key key}) : super(key: key);
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amtInputController = TextEditingController();
  SharedPreferences sharedPreferences;

  double width;

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 80,
          width: width,
          decoration: BoxDecoration(
            color: Colors.blue[500],
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circularContainer(300, Colors.blue[500])),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circularContainer(width * .5, Colors.blue[500])),
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
                                      "Buy Electricity",
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

  Widget _amtField() {
    String price = '\$0.024 W/h';
    return Container(
        padding: EdgeInsets.all(20.0),
        width: 250,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Column(children: <Widget>[
              Text(
                "Price of Electricity",
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(height: 10),
              Text(price,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold))
            ]),
          ),

          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text("Enter amount to buy (Wh)",
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
          ),
          // TextField(
          //     controller: new TextEditingController.fromValue(
          //         new TextEditingValue(
          //             text: amt,
          //             selection:
          //                 new TextSelection.collapsed(offset: amt.length - 1))),
          //     onChanged: (_inputPrice) => amt = _inputPrice,
          //     style: TextStyle(fontSize: 30),
          //     textAlign: TextAlign.center,
          //     keyboardType:
          //         TextInputType.numberWithOptions(signed: true, decimal: true),
          //     autofocus: true),
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
                        controller: _amtInputController,
                        onChanged: (text) {
                          print(text);
                        },
                        textAlign: TextAlign.center,
                        decoration:
                            InputDecoration(hintText: 'Min. amount: 1')),
                  ]))
        ]));
  }

  Future<http.Response> attemptPurchase(String amtInput) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    String amtInput = _amtInputController.text;
    print('amt input:');
    print(amtInput);

    var url = "https://soular-microservices.azurewebsites.net/api/purchase";

    final http.Response res = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'amount': amtInput,
        }));
    print('HERE');
    print(res.statusCode);
    print(res.headers);
    print(res.body);
    // print(res.statusCode);
    return res;
  }

  void _showDialogPayment() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Amount to be paid:"),
          content: new Text(" \$0.92"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
                _succesfulPayment();
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          elevation: 24.0,
        );
      },
    );
  }

  void _succesfulPayment() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Congratulations!"),
          content: new Text("Payment is successful"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
            ),
          ],
          elevation: 24.0,
        );
      },
    );
  }

  // helper methods to make everything more succint
  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Widget _elecInfo() {
    return Container(child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.lightbulb_outline ),
              title: Text('FYI'),
              subtitle: Text('100W can power up one lightbulb for 1 hour'),
            ),

          ],
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      child: Column(children: <Widget>[
        _header(context),
        SizedBox(height: 20),
        _amtField(),
        SizedBox(height: 20),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 10),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  var amtInput = _amtInputController.text;
                  var res = await attemptPurchase(amtInput);

                  if (res.statusCode == 200) {
                    // displayDialog(context, "Success", "Password Changed.");
                    _showDialogPayment();
                    _amtInputController.clear();
                  } else if (res.statusCode == 400) {
                    print(res.headers);
                    displayDialog(context, "Bad Input param", "400");
                  } else if (res.statusCode == 403) {
                    print(res.headers);
                    displayDialog(
                        context, "Purchase failed", "Insufficient credits");
                  } else if (res.statusCode == 401) {
                    print("401");
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
                    attemptPurchase(amtInput);

                    // displayDialog(context, "Unauthorized purchase", "401");

                  } else {
                    displayDialog(
                        context, "Error", "An unknown error occurred.");
                  }
                  print('processing data');
                }
              },
              color: Colors.green,
              textColor: Colors.white,
              child: Text("Proceed to Payment".toUpperCase(),
                  style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
        SizedBox(height: 20),
        _elecInfo()
      ]),
    )));
  }
}
