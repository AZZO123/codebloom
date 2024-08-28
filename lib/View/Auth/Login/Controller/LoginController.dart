// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:palnt_app/Services/NetworkClient.dart';
import 'package:palnt_app/Model/User.dart';
import 'package:palnt_app/Services/network_connection.dart';
import 'package:palnt_app/View/Home/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:palnt_app/Constant/url.dart';
import 'package:palnt_app/Controller/ServicesProvider.dart';
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/Services/Failure.dart';
import 'package:palnt_app/View/Auth/Signup/Controller/SignupController.dart';
import 'package:palnt_app/View/Auth/Signup/Signup.dart';

class LoginController with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  User user = User();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.clear();
    passwordcontroller.clear();

    log("close login");
    super.dispose();
  }

  Future<void> Login(BuildContext context) async {
    EasyLoading.show();
    try {
      // FirebaseMessaging messaging = FirebaseMessaging.instance;

      // String? token = await messaging.getToken();
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        log(emailcontroller.text);
        log(passwordcontroller.text);
        final response = await client.request(
          requestType: RequestType.POST,
          path: AppApi.LOGIN,
          body: {
            "email": emailcontroller.text,
            "password": passwordcontroller.text,
            // "device_token": token.toString() ?? '',
          },
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          CustomRoute.RouteAndRemoveUntilTo(context, HomePage());
          var res = jsonDecode(response.body);
          user = User.fromJson(res['data']);
          ServicesProvider.saveuser(user);
          EasyLoading.dismiss();
        } else if (response.statusCode == 404) {
          EasyLoading.dismiss();
          EasyLoading.showError(ResultFailure('').message);
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError(ServerFailure().message);
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(InternetFailure().message);
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      EasyLoading.dismiss();
      EasyLoading.showError(GlobalFailure().message);
    }
  }

  toSignUpPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        create: (context) => SignupController(),
        lazy: true,
        builder: (context, child) => SignUp(),
      ),
    );
  }
}
