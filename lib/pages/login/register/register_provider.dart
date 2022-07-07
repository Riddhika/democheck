import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../../../app/utils/api_responce.dart';
import 'register_model.dart';

enum RegisterStatus{initial,success,waiting,failure}

class RegisterProvider extends ChangeNotifier {
  RegisterStatus status = RegisterStatus.initial;

  Future<RegisterModel?> registerapi({BuildContext? context,required Map request}) async {
    try {
      status = RegisterStatus.waiting;
      notifyListeners();
      //TODO PASE URL HERE
      var url = Uri.parse('');
      final response = await  http.post((url), body: request);

      var responseJson = apiResponse(response: response, context: context!);
      RegisterModel? registermodel = responseJson != null ? RegisterModel.fromJson(
          responseJson) : null;
      if (responseJson == null) {
        status = RegisterStatus.failure;
      }
      else {
        status = RegisterStatus.success;
      }
      notifyListeners();
      return registermodel;
    } on Exception {
      status = RegisterStatus.failure;
      notifyListeners();
      return null;
    }
  }
}