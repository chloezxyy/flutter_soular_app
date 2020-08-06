import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_soular_app/src/pages/main_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/energy_info.dart';

class BuyPage extends StatefulWidget {
  BuyPage({Key key}) : super(key: key);
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  Future<EnergyInfo> energyInfo;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amtInputController = TextEditingController();
  // SharedPreferences sharedPreferences;
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
    return Container(
        padding: EdgeInsets.all(20.0),
        width: 250,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text("Enter amount to buy (Wh)",
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
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

  Widget _priceField() {
    return Container(
        padding: EdgeInsets.all(20.0),
        width: 250,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Column(children: <Widget>[
              Text(
                "Price of Electricity (\$ W/h)",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
            ]),
          ),
        ]));
  }

  @override
  void initState() {
    super.initState();
    energyInfo = getEnergyInfo();
  }

  Widget energyInfoWidget() {
    return Container(
        child: FutureBuilder<EnergyInfo>(
      future: energyInfo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data.currentPrice.toString(),
            style: TextStyle(
                color: Colors.blue, fontSize: 25, fontWeight: FontWeight.w500),
          );
        } else if (snapshot.hasError) {
          print("${snapshot.error}");
          // return Text(
          //   "\$ 0.024 W/h",
          //   style: TextStyle(
          //       color: Colors.blue, fontSize: 25, fontWeight: FontWeight.w500),
          // );
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    ));
  }

  Future<http.Response> attemptPurchase(String amtInput) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    // print('amt input:');
    // print(amtInput);
    var url = "https://soular-microservices.azurewebsites.net/api/purchase";
    final http.Response res = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'amount': amtInput,
        }));
    print('attemptPurchase func');
    print(res.statusCode);
    print(res.headers);
    print(res.body);
    // print(res.statusCode);
    return res;
  }

  Future<EnergyInfo> getEnergyInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = "https://soular-microservices.azurewebsites.net/api/energy_info";
    final http.Response res = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    // print('getEnergyInfo');
    // print('rescode: ${res.statusCode}');
    // // print('res.headers: ${res.headers}');
    // print('res.body: ${res.body}');
    // print('json: $json');

    return EnergyInfo.fromJson(json.decode(res.body));
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
    return Container(
        child: Card(
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: ExpansionTile(
          title: Text('Appliances usage'),
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Lightbulb'),
              subtitle: Text('100W powers up one lightbulb for 1 hour'),
            ),
            const ListTile(
              leading: Icon(Icons.power),
              title: Text('Fan'),
              subtitle: Text(' 80W powers up one fan for 1 hour'),
            )
          ],
        ),
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
        _priceField(),
        energyInfoWidget(),
        _amtField(),
        // SizedBox(height: 20),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 10),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)),
              // onPressed: (){
              //   _showDialogPayment()''
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
                        context, "Purchase failed", "Insufficient credits/energy");
                  } else if (res.statusCode == 401) {
                    print("HERE 401");
                    // get new refresh token
                    refreshToken();
                    print('attempt to purchase again');
                    attemptPurchase(amtInput);
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
        _elecInfo(),
      ]),
    )));
  }

  void refreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String refreshtoken = prefs.getString('refreshtoken'); // refresh token
    String token = prefs.getString('token');
    // String token = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMsInVzZXJuYW1lIjoidGVzdCIsImV4cCI6MTU5NjYwMTU5MiwiaWF0IjoxNTk2NjAwNjkyfQ.nxcA7vN2rDDEIGFmYW3BbgKBY2Gey1_9SG2hIHqes4DZOUBt9psHDIueWRoixDq0i4EYwW3Gn9-x1lVp37u-zocNrhhiHI4ufMXmLiNZocl8_65IxgThGQAVYAOqaGdhDNm3ZY-_0AtaoE8R0rUBIGzJc9C_Ql80ql4NYQxqPoYexpCHLUY5nFP5hSv5hHOdOHoEOgP5TLPqDuotkbsN9UydO6QcwlyOBDVZMuO-n27i7AtbE8Fk0YRneVgdDQfUAtZw3unRC87W1Vo6Tl2qVD1ap-zivWJoIst3u3DYgWFsnMftvptjIgC576_CvRz99Rf8suar-NSH1DnZJ8JDNw';
    print('Token : ${token}');
    var url =
        "https://soular-microservices.azurewebsites.net/api/refresh_token";

    final http.Response res = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'refreshToken': refreshtoken,
        }));

    // set new access token
    var jsonData = null;
    jsonData = json.decode(res.body);
    print('jsondata');
    print(jsonData);

    setState(() {
      prefs.setString("token", jsonData["accessToken"]);
      prefs.setString("refreshtoken", jsonData["refreshToken:"]);
    });
  }
}

