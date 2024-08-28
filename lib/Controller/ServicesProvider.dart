// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:palnt_app/Model/User.dart';
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/View/Auth/Login/Controller/LoginController.dart';
import 'package:palnt_app/View/Auth/Login/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesProvider with ChangeNotifier {
  static SharedPreferences? sharedPreferences;

  ServicesProvider();
  static User? user;
  static String gettoken() {
    Future.delayed(Duration.zero).then((value) async {
      sharedPreferences = await SharedPreferences.getInstance();
    });
    return sharedPreferences!.getString('token') ?? "";
  }

  static Future<void> saveuser(User user) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString('token', user.token!);
    sharedPreferences!.setBool('isLoggin', true);
  }

  static Future<void> logout(BuildContext context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.remove('token');
    sharedPreferences!.remove('isLoggin');
    CustomRoute.RouteAndRemoveUntilTo(
      context,
      ChangeNotifierProvider(
        create: (context) => LoginController(),
        builder: (context, child) => LoginPage(),
      ),
    );
  }

  static Future<bool> isLoggin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getBool('isLoggin') ?? false;
  }

  Future<SharedPreferences> sharedprefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!;
  }
}
