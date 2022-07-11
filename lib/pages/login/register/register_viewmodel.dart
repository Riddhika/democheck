import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../otp_varify_screen/otp_varify_screen.dart';
import 'register.dart';
import 'register_model.dart';


FirebaseFirestore? firebaseFirestore;
SharedPreferences? prefs;


class RegisterPageViewModel {
  RegisterPageState? state;

  // ignore: non_constant_identifier_names
  RegisterViewModel({RegisterPageState? state}) {
    this.state = state!;
  }

  // ignore: non_constant_identifier_names
  Future RegisterPageLogin(provider) async {
    // String fcmToken = await getFCMToken();
    Map requestParams = {
      "firstName": state!.fnController.text,
      "lastName": state!.lnController.text,
      "userName": state!.usernameController.text,
      "email": state!.emailController.text,
      "password": state!.passController.text,
      "deviceType": Platform.isAndroid ? "android" : "ios",
      // "deviceToken": fcmToken
    };
    ResponseData responseData = await provider.callLogin(request: requestParams, context: state!.context);
    Navigator.push(
        state!.context,
        MaterialPageRoute(
          builder: (context) => OtpVarifyScreen(
            responseData: responseData,
            email: state!.email,
            token: responseData.token,
          ),
        )
    );
  }
}

// pinal added