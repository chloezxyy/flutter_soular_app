import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_soular_app/src/helper/quad_clipper.dart';
import 'package:flutter_soular_app/src/pages/marketplace/buy_page.dart';
import 'package:flutter_soular_app/src/theme/color/light_color.dart';


class MarketPlace extends StatefulWidget {
  // final String jwt;
  // final Map<String, dynamic> payload;
  // MarketPlace(this.jwt, this.payload);
  MarketPlace({Key key}) : super(key: key);
  @override
  _MarketPlaceState createState() => _MarketPlaceState();

    // factory MarketPlace.fromBase64(String jwt) =>
    // MarketPlace(
    //   jwt,
    //   json.decode(
    //     ascii.decode(
    //       // get the username ?
    //       base64.decode(base64.normalize(jwt.split(".")[1]))
    //     )
    //   )
    // );
}

class _MarketPlaceState extends State<MarketPlace> {
  double width;

  
  // final String jwt;
  // final Map<String, dynamic> payload;

  // _MarketPlaceState(this.jwt, this.payload);

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 80,
          width: width,
          decoration: BoxDecoration(
            color: Colors.green[500],
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circularContainer(300, Colors.green[500])),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circularContainer(width * .5, Colors.green[500])),
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
                                      "Energy MarketPlace",
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

  Widget _grid() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17),
      height: 1000.0,
      child: Container(
        child: GridView.count(
          primary: true,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            InkWell(
              child: _houseContainer("House 1", " \$ 0.12kWh"),
              onTap: () {
                _onButtonPressed();
              },
            ),
            InkWell(
              child: _houseContainer("House 2", " \$ 0.31kWh"),
              onTap: () {
                _onButtonPressed();
              },
            )
          ],
        ),
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
            padding: EdgeInsets.only(top: 1.0),
            child: Text(
              elecPrice,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
        ]));
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

  Widget _featuredRowB() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // _card(
            //     primary: LightColor.seeBlue,
            //     chipColor: LightColor.seeBlue,
            //     backWidget: _decorationContainerD(
            //         LightColor.darkseeBlue, -100, -65,
            //         secondary: LightColor.lightseeBlue,
            //         secondaryAccent: LightColor.seeBlue),
            //     chipText1: "House 1 ",
            //     chipText2: "Electricity",
            //     isPrimaryCard: true,
            //     imgPath: ""),
            _card(
                primary: Colors.white,
                chipColor: LightColor.lightpurple,
                backWidget: _decorationContainerE(
                  LightColor.lightpurple,
                  90,
                  -40,
                  secondary: LightColor.lightseeBlue,
                ),
                chipText1: "House 2",
                chipText2: "Electricity",
                imgPath: ""),
            _card(
                primary: Colors.white,
                chipColor: LightColor.lightOrange,
                backWidget: _decorationContainerF(
                    LightColor.lightOrange, LightColor.orange, 50, -30),
                chipText1: "House 3",
                chipText2: "Electricity",
                imgPath: ""),
          ],
        ),
      ),
    );
  }

  Widget _decorationContainerD(Color primary, double top, double left,
      {Color secondary, Color secondaryAccent}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: secondary,
          ),
        ),
        _smallContainer(LightColor.yellow, 18, 35, radius: 12),
        Positioned(
          top: 130,
          left: -50,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: primary,
            child: CircleAvatar(radius: 50, backgroundColor: secondaryAccent),
          ),
        ),
        Positioned(
          top: -30,
          right: -40,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerE(Color primary, double top, double left,
      {Color secondary}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: primary.withAlpha(100),
          ),
        ),
        Positioned(
            top: 40,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: primary, radius: 40))),
        Positioned(
            top: 45,
            right: -50,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: secondary, radius: 50))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Widget _decorationContainerF(
      Color primary, Color secondary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 25,
            right: -20,
            child: RotatedBox(
              quarterTurns: 1,
              child: ClipRect(
                  clipper: QuadClipper(),
                  child: CircleAvatar(
                      backgroundColor: primary.withAlpha(100), radius: 50)),
            )),
        Positioned(
            top: 34,
            right: -8,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: secondary.withAlpha(100), radius: 40))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Positioned _smallContainer(Color primary, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primary.withAlpha(255),
        ));
  }

  Widget _card(
      {Color primary = Colors.redAccent,
      String imgPath,
      String chipText1 = '',
      String chipText2 = '',
      Widget backWidget,
      Color chipColor = LightColor.orange,
      bool isPrimaryCard = false}) {
    return Container(
        height: isPrimaryCard ? 190 : 180,
        width: isPrimaryCard ? width * .4 : width * .4,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: primary.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: LightColor.lightpurple.withAlpha(20))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                backWidget,
                Positioned(
                    top: 20,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(imgPath),
                    )),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: _cardInfo(chipText1, chipText2,
                      LightColor.titleTextColor, chipColor,
                      isPrimaryCard: isPrimaryCard),
                )
              ],
            ),
          ),
        ));
  }

  Widget _cardInfo(String title, String courses, Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            width: width * .32,
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isPrimaryCard ? Colors.white : textColor),
            ),
          ),
          SizedBox(height: 5),
          _chip(courses, primary, height: 5, isPrimaryCard: isPrimaryCard)
        ],
      ),
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }

  String _selectedItem = '';


  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 210,
                      child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(30),
                      topRight: const Radius.circular(30))),
            ),
          );
        });
  }

  Column _buildBottomNavigationMenu() {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Indicate amount of electricity needed')),
        ListTile(
          leading: Icon(Icons.assessment),
          title: Text('Let the system suggest'),
          onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BuyPage())),
        ),
        ListTile(
          leading: Icon(Icons.accessibility_new),
          title: Text('Input my own amount'),
          onTap: () => _selectItem('Input my own amount'),
        ),

      ],
    );
  }

  void _selectItem(String name) {
    // Navigator.pop(context);
    setState(() {
      _selectedItem = name;
    });
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
          _categoryRow("Contracts"),
          // _featuredRowB(),
          SizedBox(height: 20),
          _grid(),
        ],
      ),
    )));
  }
}
