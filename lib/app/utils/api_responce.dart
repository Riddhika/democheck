import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

dynamic apiResponse(
    {http.Response? response, BuildContext? context}) {
  if (response == null) {
    print("Response ->null");
    return null;
  }
  // ignore: unnecessary_null_comparison
  if (response.body == null) {
    print('Response body ->null');
    return null;
  }

  // 200 -> Success
  // 400 -> Bad request
  // 302 -> code only as a response for GET
  // 401 -> Unauthenticated
  // 404 -> Resource Not found

  print('Response ->${response.statusCode}');
  Map<String, dynamic> responseJson = jsonDecode(response.body.toString());
  switch (response.statusCode) {
    case 200:
      print('Response is ${response.body.toString()}');
      return responseJson;
    case 302:
      print('Response is ${response.body.toString()}');
      return responseJson;
    case 400:
      print('Response is  ${response.body.toString()}"');
      return responseJson;
    case 401:
      print('Response 401  ${response.body.toString()}"');
      return responseJson;
    case 403:
      print('Response is  ${response.body.toString()}"');
      return responseJson;
    case 404:
      print('Response is  ${response.body.toString()}"');
      return responseJson;
    case 503:
      print('No internet Connection');
      return responseJson;
  }
}
