// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:palnt_app/Controller/ServicesProvider.dart';
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/View/Auth/Login/Controller/LoginController.dart';
import 'package:palnt_app/View/Auth/Login/LoginPage.dart';
import 'package:palnt_app/View/Home/HomePage.dart';

import 'package:provider/provider.dart';

class SplashController with ChangeNotifier {
  whenIslogin(BuildContext context) async {
    Future.delayed(Duration(seconds: 5)).then((value) async {
      if (await ServicesProvider.isLoggin()) {
        toHomePage(context);
      } else {
        toAuthPage(context);
      }
    });
  }

  toHomePage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      HomePage(),
    );
  }

  toAuthPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        create: (context) => LoginController(),
        lazy: true,
        child: LoginPage(),
      ),
    );
  }
}
