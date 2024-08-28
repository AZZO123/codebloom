import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:palnt_app/Constant/url.dart';
import 'package:palnt_app/Model/Plantfromapi.dart';
import 'package:palnt_app/Services/Failure.dart';
import 'package:palnt_app/Services/NetworkClient.dart';
import 'package:http/http.dart' as http;
import 'package:palnt_app/Services/network_connection.dart';

class MyCollectionController with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  List<Plantapi> listplant = [];
  Future<void> getplants() async {
    listplant.clear();
    notifyListeners();
    EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.plants,
        );

        log(response.body);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          for (var element in data['data']) {
            listplant.add(Plantapi.fromJson(element));
          }
          notifyListeners();
          EasyLoading.dismiss();
        } else if (response.statusCode == 404) {
          EasyLoading.dismiss();
          EasyLoading.showError(ResultFailure('').message);
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError(ServerFailure().message);
        }
      }
    } catch (e) {
      log(e.toString());
      EasyLoading.dismiss();
      EasyLoading.showError(GlobalFailure().message);
    }
  }
}
