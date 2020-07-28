import 'package:flutter/material.dart';
import 'package:flutter_soular_app/src/helper/quad_clipper.dart';
import 'package:flutter_soular_app/src/pages/marketplace/buy_page.dart';
import 'package:flutter_soular_app/src/pages/marketplace/sell_page.dart';
import 'package:flutter_soular_app/src/widgets/newsList.dart';
import 'package:flutter_soular_app/src/theme/color/light_color.dart';
import 'package:flutter_soular_app/src/pages/wallet/wallet_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_soular_app/src/widgets/newsList.dart';
import 'dart:convert' show json, base64, ascii;

class HomePage extends StatefulWidget {
  // HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  // final String jwt;
  // final Map<String, dynamic> payload;

  // HomePage(this.jwt, this.payload);
  // factory HomePage.fromBase64(String jwt) =>
  //   HomePage(
  //     jwt,
  //     json.decode(
  //       ascii.decode(
  //         // get the username ?
  //         base64.decode(base64.normalize(jwt.split(".")[1]))
  //       )
  //     )
  //   );
}

class _HomePageState extends State<HomePage> {
// class HomePage extends StatelessWidget{

  double width;

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 175,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.purple,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(300, LightColor.lightpurple)),
              Positioned(
                  top: -100,
                  left: -45,
                  child: _circularContainer(width * .5, LightColor.darkpurple)),
              Positioned(
                  top: -180,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 40,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Your Account Value",
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder:(context) => WalletPage())
                                  );
                                },
                                child: Text('MANAGE WALLET',
                                    style: TextStyle(color: Colors.white)),
                                // textColor: Colors.lime,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(20)),
                              )
                            ],
                          ),
                          SizedBox(height: 1),
                          Text(
                            " USD 48.42 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          ),
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

  Widget _graphTitle(String title) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 30,
        // padding: const EdgeInsets.all(3.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Container(
            // padding: EdgeInsets.all(1.0),
            child: Text(
              title,
              style: TextStyle(
                  color: LightColor.titleTextColor,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]));
  }

  Widget _graphImage() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 200,
        // padding: const EdgeInsets.all(3.0),
        child:
            FittedBox(
              // padding: EdgeInsets.all(1.0),
              child: Image.asset('assets/images/graph.jpg'),
              fit: BoxFit.fill
    ));
  }

  Widget _buyRow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17),
      height: 40,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              " Buy Electricity From Microgrid",
              style: TextStyle(
                  color: LightColor.titleTextColor,
                  fontWeight: FontWeight.bold),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BuyPage()));
              },
              child: Text('BUY', style: TextStyle(color: Colors.blueAccent)),
              // textColor: Colors.lime,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.blueAccent,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(20)),
            )
          ],
        ),
      ),
    );
  }

  Widget _sellRow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17),
      height: 40,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              " Sell Electricity From Microgrid",
              style: TextStyle(
                  color: LightColor.titleTextColor,
                  fontWeight: FontWeight.bold),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SellPage()));
              },
              child: Text('SELL', style: TextStyle(color: Colors.green)),
              // textColor: Colors.lime,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.green, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
      ),
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
          // _chip("Manage", primary)
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: <Widget>[
            _header(context),
            SizedBox(height: 20),
            _buyRow(),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            _sellRow(),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            _graphTitle("Your Electricity Consumption"),
            _graphImage(),
            // _categoryRow("Houses"),
            // _featuredRowB(),
            SizedBox(height: 5),
            _categoryRow("News"),
            NewsList(),
            // _featuredRowNews(),
          ],
        ),
      )),
    );
  }
}
