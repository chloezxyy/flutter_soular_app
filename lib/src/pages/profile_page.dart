import 'package:flutter/material.dart';
import 'package:flutter_soular_app/src/pages/edit_page.dart';
import 'package:flutter_soular_app/src/pages/login_page.dart';
import 'package:flutter_soular_app/src/theme/color/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  // profilepage's constructor
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    getUsername();
  }

  SharedPreferences sharedPreferences;

  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  // set true when user tape on text
  bool _isEditingText = false;

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  double width;
  var profileInfo = ['@khamkk'];
  String getProfileInfoString() {
    StringBuffer sb = new StringBuffer();
    for (String line in profileInfo) {
      sb.write(line + "\n");
    }
    return sb.toString();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
            color: LightColor.grey,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circularContainer(300, LightColor.grey)),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circularContainer(width * .5, Colors.grey[600])),
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
                                "Your Profile",
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
            padding: EdgeInsets.symmetric(horizontal: 90),
            child: Center(
              child: Column(
                children: <Widget>[
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
                ],
              ),
            )),
        SizedBox(height: 20),
        RaisedButton(
          textColor: Colors.white,
          color: Colors.grey,
          child: Text("Edit Profile"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditPage()),
            );
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
        RaisedButton(
          textColor: Colors.white,
          color: Colors.redAccent,
          child: Text("Sign Out"),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => LoginPage()),
            // );

            sharedPreferences.clear();
            // ignore: deprecated_member_use
            sharedPreferences.commit();
            // checkLoginStatus();
            Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        )
      ],
    )));
  }

  //  void _saveChanges() {
  //    if (formKey.currentState.validate()){
  //      formKey.currentState.save();
  //      print(_usernameController);
  //      print(_passwordController);
  //    }
  //   }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }
  String username;
  getUsername() async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        username = pref.getString("username") ?? 'hi';
        print(username);
        return username;
    }
    Widget name(){return ListTile(title: Text(getUsername()));}


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
          _profile(),

        ],
      ),
    )));
  }

}
