import 'package:flutter/material.dart';
import 'package:flutter_soular_app/src/pages/login_page.dart';
import 'package:flutter_soular_app/src/theme/color/light_color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPage extends StatefulWidget {
  // profilepage's constructor
  EditPage({Key key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  double width;

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
                      //  padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Edit Profile",
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

  Future<http.Response> attemptEditPassword(String username, String password) async {
    String password = _passwordController.text;
    var url =
        "https://soular-microservices.azurewebsites.net/api//change_password";

    final http.Response res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'username': username, 'password': password}));


    print('pw: ${password}');
    print('body: ${res.body}');
    print(res.statusCode);
    print(res.headers);
    return res;
  }

  Widget _profile() {
    return Container(
        child: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
                  TextFormField(
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _usernameFocus, _passwordFocus);
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _usernameFocus,
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (input) => input.length < 5
                          ? 'You need at least 5 characters'
                          : null,
                      onSaved: (input) => _usernameController.text = input,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                  TextFormField(
                      //       onFieldSubmitted: (term) {
                      // _fieldFocusChange(context, _usernameFocus, _passwordFocus);},
                      textInputAction: TextInputAction.done,
                      focusNode: _passwordFocus,
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (input) => input.length < 8
                          ? 'You need at least 8 characters'
                          : null,
                      onSaved: (input) => _passwordController.text = input,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey))
                ],
              ),
            )),
        SizedBox(height: 20),
        RaisedButton(
          textColor: Colors.white,
          color: Colors.green,
          child: Text("Submit"),
          onPressed: () {

          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      ],
    )));
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
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
          _profile(),
        ],
      ),
    )));
  }
}
