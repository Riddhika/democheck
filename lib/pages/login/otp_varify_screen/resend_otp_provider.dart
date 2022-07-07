import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import '../../../app/utils/api_responce.dart';
enum ResendOtpStatus{initial,success,waiting,failure}

class ResendOtpProvider extends ChangeNotifier {
  ResendOtpStatus status = ResendOtpStatus.initial;

  Future<dynamic> callResendOtp({BuildContext? context, required Map requestParams, token}) async {
    try {
      status = ResendOtpStatus.waiting;
      notifyListeners();
      //TODO API CALL HERE
      var url = Uri.parse('');
      print("Path -> $url");
      print("Bearer Token -> $token");
      Map<String, String> header = {
        'Authorization': token,
      };
      print("Header :- $header");
      print("requestParams :- $requestParams");
      final response = await http.post((url), headers: header, body: requestParams);
      print("body :- ${response.body}");
      var responseJson = apiResponse(response: response, context: context!);
      if (responseJson == null) {
        status = ResendOtpStatus.failure;
      }
      else {
        status = ResendOtpStatus.success;
      }
      notifyListeners();
      return responseJson;
    } on Exception {
      status = ResendOtpStatus.failure;
      notifyListeners();
      return null;
    }
  }
}