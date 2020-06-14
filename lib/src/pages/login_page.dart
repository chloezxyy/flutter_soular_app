import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_soular_app/src/pages/home_page.dart';
import 'package:flutter_soular_app/src/pages/main_page.dart';
import 'package:flutter_soular_app/src/pages/profile_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show ascii, base64, base64Encode, json, utf8;

const SERVER_IP = 'http://192.168.1.167:5000';
final storage = FlutterSecureStorage();

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );


  // return a string for the login method, null in case of an error
  Future<String> attemptLogIn(String username, String password) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var res = await http.get("https://soular-microservices.azurewebsites.net/api/login",
        headers: <String, String>{'Authorization': basicAuth}
        );
    if (res.statusCode == 200) return res.body;
    return null;
  }

  Future<int> attemptRegister(String username, String password) async {
        String username = _usernameController.text;
    String password = _passwordController.text;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var res = await http.post('https://soular-microservices.azurewebsites.net/api/register',
        headers: <String, String>{'Authorization': basicAuth}
        );
    return res.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 30.0,
        child: Image.asset('assets/images/soular_fulllogo.png'),
      ),
    );


    // final password = TextFormField(
    //   keyboardType: TextInputType.text,
    //   // controller: _passwordController,
    //   autofocus: false,
    //   initialValue: 'some password',
    //   obscureText: true,
    //   decoration: InputDecoration(
    //     hintText: 'Password',
    //     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    //   ),
    // );


    final username = TextField(
      controller: _usernameController,
      decoration: InputDecoration(labelText: 'Username'),
    );


    final password = TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          print("log in button pressed");

          var username = _usernameController.text;
          var password = _passwordController.text;

          var jwt = await attemptLogIn(username, password);
          if (jwt != null) {
            storage.write(key: "jwt", value: jwt);
            Navigator.push(
                context,
                MaterialPageRoute(
                    // HomePage.fromBase64(jwt)
                    // builder: (context) => HomePage.fromBase64(jwt)
                    // builder: (context) => ProfilePage()
                    builder: (context) => HomePage()


                    )
                    );
          } else {
            displayDialog(context, "An Error Occurred",
                "No account was found matching that username and password");
          }
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => MainPage()));
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          print("register button pressed");

          var username = _usernameController.text;
          var password = _passwordController.text;

          if (username.length < 4)
            displayDialog(context, "Invalid Username",
                "The username should be at least 4 characters long");
          else if (password.length < 4)
            displayDialog(context, "Invalid Password",
                "The password should be at least 4 characters long");
          else {
            var res = await attemptRegister(username, password);
            if (res == 201)
              displayDialog(
                  context, "Success", "The user was created. Log in now.");
            else if (res == 409)
              displayDialog(context, "That username is already registered",
                  "Please try to sign up using another username or log in if you already have an account.");
            else {
              displayDialog(context, "Error", "An unknown error occurred.");
            }
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child:
            Text('Register', style: TextStyle(color: Colors.lightBlueAccent)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            username,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            registerButton,
            forgotLabel,
            
          ],
        ),
      ),
      
    );
  }
}
