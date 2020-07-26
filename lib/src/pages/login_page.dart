import 'package:flutter/material.dart';
import 'package:flutter_soular_app/src/pages/main_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// Create storage
// final storage = FlutterSecureStorage();

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  // helper methods to make everything more succint
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
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    // ignore: avoid_init_to_null
    var jsonData = null;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var res = await http.get(
        "https://soular-microservices.azurewebsites.net/api/login",
        headers: <String, String>{'authorization': basicAuth},

        );

    print('resbody: ');
    print(res.headers);
    
    if (res.statusCode == 200) {
      print(res.statusCode);

      jsonData = json.decode(res.body);
      print(jsonData);

      setState(() {
        _isLoading = false;
        sharedPreferences.setString("token", jsonData["accessToken"]);
        sharedPreferences.setString("username", username);
        print(username);
        print('share');

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage()),
            (Route<dynamic> route) => false);
            
      });
      return res.body;
    }

    print("attemptLogIn returns null jwt");
    print(res.statusCode);
    return null;
  }

  Future<http.Response> attemptRegister(
      String username, String password) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    var url = "https://soular-microservices.azurewebsites.net/api/register";
    
    final http.Response res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'username': username, 'password': password}));

    print('username: ${username}');
    print('pw: ${password}');
    print('body: ${res.body}');
    print(res.statusCode);
    print(res.headers);
    return res;
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

    final username = TextField(
      controller: _usernameController,
      decoration: InputDecoration(labelText: 'Username'),
    );

    final password = TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
    );


    final loginButton = _isLoading ? Center(child: CircularProgressIndicator()) : Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          var username = _usernameController.text;
          var password = _passwordController.text;
          var jwt = await attemptLogIn(username, password);

          if (jwt != null) {
            attemptLogIn(username, password);
          } else {
            setState(() {
            _isLoading = false;
          });
            return displayDialog(
              context,
              "An Error Occurred",
              "No account was found matching that username and password",
            );
          }
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
            if (res.statusCode == 201) {
              displayDialog(
                  context, "Success", "The user was created. Log in now.");
              _usernameController.clear();
              _passwordController.clear();
            } else if (res.statusCode == 409)
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
      key: _scaffoldKey,
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
