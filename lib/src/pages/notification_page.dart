import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_soular_app/src/theme/color/light_color.dart';
import 'package:flutter_soular_app/src/pages/recomended_page.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  double width;
  var profileInfo = ['1234', '99999999'];
  String getProfileInfoString() {
    StringBuffer sb = new StringBuffer();
    for (String line in profileInfo) {
      sb.write(line + "\n");
    }
    return sb.toString();
  }

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 120,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.lightBlue,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circularContainer(300, LightColor.lightBlue)),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circularContainer(width * .5,Colors.indigo[900])),
              Positioned(
                  top: -230,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 50,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Your Notifications",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500),
                              ))
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

    Widget _courseList() {
      return Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Hi"),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
          ],
        ),
      );
    }
  }

  Widget _profile() {
    return Container(
        child: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
            backgroundImage: AssetImage('assets/images/profilepic.jpg'),
            radius: 60.0),
        SizedBox(height: 20.0),
        Text(
          "Kham Keow",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, color: Colors.black),
        ),
        Container(
          child: Center(
              child: Text(
            getProfileInfoString(),
            textAlign: TextAlign.center,
            maxLines: 20,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          )),
        ),
        RaisedButton(
    textColor: Colors.white,
    color: Colors.grey,
    child: Text("Edit Profile"),
    onPressed: () {},
    shape: new RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(30.0),
    ),
  ),
      ],
    )));
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
          SizedBox(height: 10),
          _profile(),
        ],
      ),
    )));
  }
}
