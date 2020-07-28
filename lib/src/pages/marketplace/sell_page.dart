import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_soular_app/src/pages/main_page.dart';
import 'package:http/http.dart' as http;


class SellPage extends StatefulWidget {
  SellPage({Key key}) : super(key: key);
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amtInputController = TextEditingController();


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
            color: Colors.purple[500],
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circularContainer(300, Colors.purple[500])),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circularContainer(width * .5, Colors.purple[500])),
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
                                      "Sell Electricity",
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
    Future<http.Response> attemptPurchase(String amtInput) async {
    String amtInput = _amtInputController.text;
    print('amt input:');
    print(amtInput);

    var url = "https://soular-microservices.azurewebsites.net/api/sell";

    final http.Response res = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'amtInput': amtInput,
        }));
    print(res.statusCode);
    print(res.body);
    return res;
  }

  Widget _amtField() {
    return Container(
        padding: EdgeInsets.all(20.0),
        width: 250,
        child: Column(children: <Widget>[
          
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text("Enter amount to sell",
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(" (W/h)",
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
          ),

          Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
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

  void _showDialogSell() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Selling price:"),
          content: new Text(" \$0.92"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
                _succesfulSell();
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

  void _succesfulSell() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Congratulations!"),
          content: new Text("Energy contract is posted"),
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
                    _showDialogSell();
                    _amtInputController.clear();
                  } else if (res.statusCode == 400) {
                    print(res.headers);
                    displayDialog(context, "Bad Input", "Input valid amount");
                  } else if (res.statusCode == 401) {
                    print(res.headers);
                    displayDialog(context, "Unauthorized purhcase", "401");
                  } else if (res.statusCode == 403) {
                    print(res.headers);
                    displayDialog(context, "Purchase failed", "403");
                  } else if (res.statusCode == 500) {
                    print(res.headers);
                    displayDialog(context, "Internal server error", "500");
                  } else {
                    print(res.headers);
                    displayDialog(
                        context, "Error", "An unknown error occurred.");
                  }

                  print('processing data');
                  
                }
                
              },
              color: Colors.green,
              textColor: Colors.white,
              child: Text("Confirm Amount".toUpperCase(),
                  style: TextStyle(fontSize: 14)),
            ),
          ],
        )
      ]),
    )));
  }
}
