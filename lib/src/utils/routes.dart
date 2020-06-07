import 'package:flutter/material.dart';
import 'package:flutter_soular_app/src/pages/main_page.dart';
import 'package:flutter_soular_app/src/pages/login_page.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginPage(),
  '/home':         (BuildContext context) => new MainPage(),
  '/' :          (BuildContext context) => new LoginPage(),
};
// '/': default page