// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:palnt_app/Constant/url.dart';
import 'package:palnt_app/Controller/ServicesProvider.dart';

enum RequestType { GET, POST }

enum RequestTypeImage { POST_WITH_IMAGE, POST_WITH_MULTI_IMAGE }

class NetworkClient {
  static final String _baseUrl = AppApi.url;

  final Client _client;

  NetworkClient(this._client);
  Future<MultipartRequest> requestimage({
    required String path,
    Map<String, String>? body,
    http.MultipartFile? image,
  }) async {
    String? token = ServicesProvider.gettoken();
    log(token);
    return http.MultipartRequest(
      "POST",
      Uri.parse('$_baseUrl$path'),
    )
      ..files.add(image!)
      ..headers.addAll(
        {
          "Accept": "application/json",
          "api_key": '123456789',
          'token': '${ServicesProvider.gettoken()}'
        },
      );
  }

  Future<http.MultipartRequest> requestmultiimage({
    required String path,
    Map<String, String>? body,
    List<http.MultipartFile>? images,
  }) async {
    String? token = ServicesProvider.gettoken();
    log(token);

    final request = http.MultipartRequest(
      "POST",
      Uri.parse('$_baseUrl$path'),
    );

    if (body != null) {
      request.fields.addAll(body);
    }

    if (images != null) {
      request.files.addAll(images);
    }

    request.headers.addAll({
      "Accept": "application/json",
      "api_key": '123456789',
      'token': '${ServicesProvider.gettoken()}',
    });

    return request;
  }

  Future<MultipartRequest> requestwithotimage({
    required String path,
    Map<String, String>? body,
  }) async {
    String? token = ServicesProvider.gettoken();
    log(token);
    return http.MultipartRequest(
      "POST",
      Uri.parse('$_baseUrl$path'),
    )
      ..fields.addAll(body!)
      ..headers.addAll(
        {
          "Accept": "application/json",
          "api_key": '123456789',
          'token': '${ServicesProvider.gettoken()}'
        },
      );
  }

  Future<Response> request(
      {required RequestType requestType,
      required String path,
      Map<String, dynamic>? body,
      int TimeOut = 30}) async {
    log("$_baseUrl$path");
    log(ServicesProvider.gettoken());

    switch (requestType) {
      case RequestType.GET:
        if (ServicesProvider.user?.token != null) {
          return _client.get(Uri.parse("$_baseUrl$path"), headers: {
            "Accept": "application/json",
            "api_key": '123456789',
            'token': '${ServicesProvider.gettoken()}'
          }).timeout(Duration(seconds: TimeOut));
        } else {
          return _client.get(Uri.parse("$_baseUrl$path"), headers: {
            "Accept": "application/json",
            "api_key": '123456789',
            'token': '${ServicesProvider.gettoken()}'
          }).timeout(Duration(seconds: TimeOut));
        }

      case RequestType.POST:
        if (ServicesProvider.user?.token != null) {
          log(ServicesProvider.gettoken());

          log(body.toString());
          log("$_baseUrl$path");
          return _client
              .post(Uri.parse("$_baseUrl$path"),
                  headers: {
                    "Accept": "application/json",
                    "api_key": '${AppApi.apikey}',
                    'token': '${ServicesProvider.gettoken()}'
                  },
                  body: json.encode(body))
              .timeout(Duration(seconds: TimeOut));
        } else {
          log(ServicesProvider.gettoken());

          return _client
              .post(Uri.parse("$_baseUrl$path"),
                  headers: {
                    "Accept": "application/json",
                    "api_key": '123456789',
                    'token': '${ServicesProvider.gettoken()}'
                  },
                  body: body)
              .timeout(Duration(seconds: TimeOut));
        }
    }
  }
}
