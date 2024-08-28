// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:palnt_app/Constant/colors.dart';
import 'package:palnt_app/Controller/ServicesProvider.dart';
import 'package:palnt_app/View/Encyclopedia/EncyclopediaPage.dart';
import 'package:palnt_app/View/MyCollection/MyCollection.dart';
import 'package:palnt_app/View/WeatherPage/WeatherPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _SelectIndex = 0;
  int _intpage = 0;
  List<Widget> listwidget = [
    MyCollection(),
    EncyclopediaPage(),
    WeatherPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("CodeBloom"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_active),
          ),
          GestureDetector(
            onTap: () => ServicesProvider.logout(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: kSecendryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: 300),
            selectedIndex: _SelectIndex,
            backgroundColor: kSecendryColor,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: kBaseColor,
            gap: 8,
            padding: EdgeInsets.all(12),
            tabs: [
              GButton(
                icon: Icons.grass,
                iconColor: kBaseColor,
                iconActiveColor: kSecendryColor,
                textColor: kSecendryColor,
                text: "تشكيلتي",
              ),
              GButton(
                icon: Icons.menu_book_sharp,
                iconColor: kBaseColor,
                iconActiveColor: kSecendryColor,
                textColor: kSecendryColor,
                text: "الموسوعة",
              ),
              GButton(
                icon: Icons.cloud,
                iconColor: kBaseColor,
                iconActiveColor: kSecendryColor,
                textColor: kSecendryColor,
                text: "الطقس",
              ),
            ],
            onTabChange: (value) {
              setState(() {
                _intpage = value;
              });
            },
          ),
        ),
      ),
      body: listwidget[_intpage],
    );
  }
}
