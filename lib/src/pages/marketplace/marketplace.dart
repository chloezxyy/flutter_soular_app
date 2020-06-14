import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_soular_app/src/pages/home_page.dart';
import 'package:flutter_soular_app/src/theme/color/light_color.dart';
import 'package:flutter_soular_app/src/widgets/category_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MarketPlace extends StatelessWidget {
  MarketPlace({Key key}) : super(key: key);

  double width;
  static const IconData account_balance =
      IconData(0xe84f, fontFamily: 'MaterialIcons');

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
          children: <Widget>[_houseContainer(), _houseContainer()],
        ),
      ),
    );
  }

  Widget _houseContainer() {
    return Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 20,
                offset: Offset(0, 2),
              )
            ]),
        child: Padding(
            padding: EdgeInsets.all(16.0), child: Text('Hello World!')));
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
          _grid(),
        ],
      ),
    )));
  }
}
