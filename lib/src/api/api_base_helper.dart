import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mymoney_app/app_const.dart';
import 'package:mymoney_app/app_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://192.168.5.5:8000/api/";

  Future<dynamic> get(String url) async {
    var responseJson;

    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(token_key);

    try {
      final response = await http.get(
        _baseUrl + url,
        headers: {HttpHeaders.authorizationHeader: "Token $token"},
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, [Map<String, dynamic> body]) async {
    var responseJson;
    try {
      final response = await http.post(
        _baseUrl + url,
        body: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
