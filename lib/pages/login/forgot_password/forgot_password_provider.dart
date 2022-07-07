import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../../../app/utils/api_responce.dart';

enum ForgotPasswordStatus{initial,success,waiting,failure}

class ForgotPasswordProvider extends ChangeNotifier {
  ForgotPasswordStatus status = ForgotPasswordStatus.initial;

  Future<dynamic> callForgotPassword({BuildContext? context, required Map request}) async {
    try {
      status = ForgotPasswordStatus.waiting;
      notifyListeners();

      //TODO PASE URL HERE
      var url = Uri.parse('');
      print("Path -> $url");
      print("Request -> $request");
      final response = await http.post((url), body: request);
      var responseJson = apiResponse(response: response, context: context!);
      if (responseJson == null) {
        status = ForgotPasswordStatus.failure;
      }
      else {
        status = ForgotPasswordStatus.success;
      }
      notifyListeners();
      return responseJson;
    } on Exception {
      status = ForgotPasswordStatus.failure;
      notifyListeners();
      return null;
    }
  }
}