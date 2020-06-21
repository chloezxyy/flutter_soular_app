import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_soular_app/src/helper/quad_clipper.dart';
import 'package:flutter_soular_app/src/pages/explore_page.dart';
import 'package:flutter_soular_app/src/pages/profile_page.dart';
import 'package:flutter_soular_app/src/pages/recomended_page.dart';
import 'package:flutter_soular_app/src/pages/notification_page.dart';
import 'package:flutter_soular_app/src/theme/color/light_color.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  MainPage(this.jwt, this.payload);

  @override
  _MainPageState createState() => _MainPageState();

  final String jwt;
  final Map<String, dynamic> payload;

  factory MainPage.fromBase64(String jwt) =>
    MainPage(
      jwt,
      json.decode(
        ascii.decode(
          // get the username ?
          base64.decode(base64.normalize(jwt.split(".")[1]))
        )
      )
    );
}


class _MainPageState extends State<MainPage> {
  double width;

  int _selectedIndex = 0;
  final List<Widget> _children = [
  
    // HomePage.fromBase64(jwt),
    HomePage(),
    RecomendedPage(),
    ExplorePage(),
    NotificationPage(),
    ProfilePage()
  ];

  // static String get jwt => null;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
  });
}
  
  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(
        //  backgroundColor: Colors.blue,
        icon: Icon(icon),
        title: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: LightColor.purple,
        unselectedItemColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          _bottomIcons(Icons.home),
          _bottomIcons(Icons.history),
          _bottomIcons(Icons.explore),
          _bottomIcons(Icons.notifications),
          _bottomIcons(Icons.person),
        ],
        // onTap: (_onItemTapped) {
        //   Navigator.pushReplacement(context,
        //       MaterialPageRoute(builder: (context) => _children[_onItemTapped]));
        // },
      ),
      // body: 
      body: _children[_selectedIndex]
    );
  }
}
