import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import '../../../app/utils/api_responce.dart';
enum VerifyOTPStatus{initial,success,waiting,failure}

class VerifyOTPProvider extends ChangeNotifier {
  VerifyOTPStatus status = VerifyOTPStatus.initial;

  Future<dynamic> callVerifyOtp({required Map request, context, String? token}) async {
    try {
      status = VerifyOTPStatus.waiting;
      notifyListeners();
      //TODO PASE URL HERE
      //TODO API CALL HERE
      var url = Uri.parse("");
      print("Path -> $url");
      print("request -> ${jsonEncode(request)}");
      Map<String, String> header = {'Authorization': token!,};
      print("Header :- $header");
      final response = await http.post((url), headers: header, body: request);
      var responseJson = apiResponse(response: response, context: context);
      if (responseJson == null) {
        status = VerifyOTPStatus.failure;
      }
      else {
        status = VerifyOTPStatus.success;
      }
      notifyListeners();
      return responseJson;
    } on Exception {
      status = VerifyOTPStatus.failure;
      notifyListeners();
      return null;
    }
  }
}

