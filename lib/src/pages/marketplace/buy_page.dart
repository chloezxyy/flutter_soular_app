import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_soular_app/src/pages/home_page.dart';
import 'package:flutter_soular_app/src/pages/main_page.dart';
import 'package:flutter_soular_app/src/pages/marketplace/marketplace.dart';
import 'package:flutter_soular_app/src/theme/color/light_color.dart';


class BuyPage extends StatefulWidget {

  BuyPage(this.jwt, this.payload);
  // BuyPage({Key key, this.jwt, this.payload}) : super(key: key);
  @override
  _BuyPageState createState() => _BuyPageState(this.jwt, this.payload);
  
  final String jwt;
  final Map<String, dynamic> payload;

  factory BuyPage.fromBase64(String jwt) =>
    BuyPage(
      jwt,
      json.decode(
        ascii.decode(
          // get the username ?
          base64.decode(base64.normalize(jwt.split(".")[1]))
        )
      )
    );
}

class _BuyPageState extends State<BuyPage> {
  double width;

  final String jwt;
  final Map<String, dynamic> payload;

  _BuyPageState(this.jwt, this.payload);

  
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
                                      "Transaction",
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

  Widget _field() {
    String amt = '9.2';
    final _inputAmt = TextEditingController(text: amt);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: 250,
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text("Enter amount to buy", style: TextStyle(fontSize: 19)),
        ),
        TextField(
            controller: new TextEditingController.fromValue(
                new TextEditingValue(
                    text: _inputAmt.text,
                    selection:
                        new TextSelection.collapsed(offset: amt.length - 1))),
            onChanged: (inpAmt) => amt = inpAmt,
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            autofocus: true),
        Text("kWh")
      ]),
    );
  }

  Widget _categoryRow(
    String title,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: LightColor.titleTextColor, fontWeight: FontWeight.bold),
          ),
          Container()
          // _chip("Manage", primary)
        ],
      ),
    );
  }

  Widget _houseContainer(String houseNum, String elecPrice) {
    return Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 20,
                offset: Offset(0, 2),
              )
            ]),
        child: Column(children: <Widget>[
          InkWell(
              child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: Container(
                      child: Text(
                    houseNum,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )))),
          Padding(
              padding: EdgeInsets.all(1.0),
              child: Text('Selling at:',
                  style: TextStyle(fontSize: 10.0, color: Colors.black))),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Text(
              elecPrice,
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
        ]));
  }

  void _showDialogPayment(String jwt, Map<String, dynamic> payload) {
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
                _succesfulPayment(this.jwt, this.payload);

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

  void _succesfulPayment(String jwt, Map<String, dynamic> payload) {
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
                    MaterialPageRoute(builder: (context) =>MainPage(this.jwt, this.payload)));
              },
            ),
          ],
          elevation: 24.0,
        );
      },
    );
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
        _field(),
        SizedBox(height: 20),
        _categoryRow("Selected house"),
        _houseContainer("House 1", " \$ 0.12kWh"),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 10),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)),
              onPressed: () {
                _showDialogPayment(this.jwt, this.payload);
              },
              color: Colors.green,
              textColor: Colors.white,
              child: Text("Proceed to Payment".toUpperCase(),
                  style: TextStyle(fontSize: 14)),
            ),
          ],
        )
      ]),
    )));
  }
}
