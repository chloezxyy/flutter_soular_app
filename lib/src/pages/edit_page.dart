import 'package:flutter/material.dart';
import 'package:flutter_soular_app/src/pages/login_page.dart';
import 'package:flutter_soular_app/src/theme/color/light_color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class EditPage extends StatefulWidget {
  // profilepage's constructor
  EditPage({Key key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final FocusNode _oldPasswordFocus = FocusNode();
  final FocusNode _newPasswordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  SharedPreferences sharedPreferences;

  double width;

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

  //  Future<String> getToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }


  Future<http.Response> attemptEditPassword(
      String oldPassword, String newPassword) async {
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
     var token = prefs.getString('token');
    print('Password text input:');
    print(oldPassword);
    print(newPassword);

    var url =
        "https://soular-microservices.azurewebsites.net/api/change_password";

    final http.Response res = await http.post(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
          'oldPassword': oldPassword,
          'newPassword': newPassword
        }));
    print(res.statusCode);
    print(res.body);
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
                            context, _oldPasswordFocus, _newPasswordFocus);
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _oldPasswordFocus,
                      decoration: InputDecoration(labelText: 'Old Password'),
                      // validator: (input) => input.length < 5
                      //     ? 'You need at least 5 characters'
                      //     : null,
                      controller: _oldPasswordController,
                      // onSaved: (input) => _oldPasswordController.text = input,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                  TextFormField(
                      //       onFieldSubmitted: (term) {
                      // _fieldFocusChange(context, _usernameFocus, _passwordFocus);},
                      textInputAction: TextInputAction.done,
                      focusNode: _newPasswordFocus,
                      decoration: InputDecoration(labelText: 'New Password'),
                      // validator: (input) => input.length < 8
                      //     ? 'You need at least 8 characters'
                      //     : null,
                      // onSaved: (input) => _newPasswordController.text = input,
                      controller: _newPasswordController,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey))
                ],
              ),
            )),
        SizedBox(height: 20),
        RaisedButton(
          textColor: Colors.white,
          color: Colors.green,
          child: Text("Submit"),
          onPressed: () async {
            sharedPreferences = await SharedPreferences.getInstance();
            var oldPassword = _oldPasswordController.text;
            var newPassword = _newPasswordController.text;
            var res = await attemptEditPassword(oldPassword, newPassword);
            if (res.statusCode == 200) {
              displayDialog(context, "Success", "Password Changed.");
              _oldPasswordController.clear();
              _newPasswordController.clear();
            } else if (res.statusCode == 400) {
              print(res.headers);
              displayDialog(
                  context, "Bad Input", "Min. 6 characters for new password");
            } else if (res.statusCode == 401) {
              print(res.headers);
              displayDialog(context, "Unauthorized", "401");
            } else if (res.statusCode == 403) {
              print(res.headers);
              displayDialog(context, "Incorrect Old Password", "- 403");
            } else {
              print(res.headers);
              displayDialog(context, "Error", "An unknown error occurred.");
            }
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      ],
    )));
  }

  // helper methods to make everything more succint
  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

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
