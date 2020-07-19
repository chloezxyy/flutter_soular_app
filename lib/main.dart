import 'package:flutter/material.dart';
import 'package:flutter_soular_app/src/pages/login_page.dart';
import 'package:flutter_soular_app/src/pages/main_page.dart';
import 'package:flutter_soular_app/src/pages/profile_page.dart';
import 'package:flutter_soular_app/src/theme/theme.dart';
import 'package:flutter_soular_app/src/widgets/newsList.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // for dark theme 
        // theme: AppTheme.lightTheme,
        home:LoginPage(),
        debugShowCheckedModeBanner: false,
        );
  }
}

