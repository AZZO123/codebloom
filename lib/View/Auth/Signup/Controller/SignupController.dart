// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:palnt_app/Constant/url.dart';
import 'package:palnt_app/Services/Failure.dart';
import 'package:palnt_app/Services/network_connection.dart';
import 'package:palnt_app/Services/NetworkClient.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/View/Auth/Login/Controller/LoginController.dart';
import 'package:palnt_app/View/Auth/Login/LoginPage.dart';

class SignupController with ChangeNotifier {
  @override
  void dispose() {
    usernamecontroller.clear();
    emailcontroller.clear();
    passwordcontroller.clear();
    confirmpasswordcontroller.clear();
    log("close signup");
    super.dispose();
  }

  static NetworkClient client = NetworkClient(http.Client());

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  Future<void> Signup(BuildContext context) async {
    EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        log(emailcontroller.text);
        log(passwordcontroller.text);
        final response = await client.request(
          requestType: RequestType.POST,
          path: AppApi.Signup,
          body: {
            "name": usernamecontroller.text,
            "email": emailcontroller.text,
            "password": passwordcontroller.text,
          },
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 201) {
          CustomRoute.RouteAndRemoveUntilTo(
            context,
            ChangeNotifierProvider<LoginController>(
              create: (context) => LoginController(),
              builder: (context, child) => LoginPage(),
            ),
          );
          EasyLoading.dismiss();
          EasyLoading.showSuccess("تم انشاء الحساب بنجاح");
        } else if (response.statusCode == 400) {
          EasyLoading.dismiss();
          EasyLoading.showToast(
              ResultFailure('البريد الالكتروني مسجل مسبقاً').message);
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

  toLoginPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        create: (context) => LoginController(),
        lazy: true,
        builder: (context, child) => LoginPage(),
      ),
    );
  }
}
