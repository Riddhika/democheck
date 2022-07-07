// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'forgot_password.dart';
import 'forgot_password_provider.dart';
import 'sent_email_forgot_password_page/sent_email_forgot_password_page.dart';

class ForgotPasswordViewModel {
  ForgotPasswordState? state;

  ForgotPasswordViewModel({ForgotPasswordState? state}) {
    this.state = state!;
  }

  ForgotPasswordProvider provider = ForgotPasswordProvider();

  Future<void> forgotPasswordApiCall() async {
    Map requestParams = {
      "email": state!.userEmailController.text,
    };
    final isForgot = await provider.callForgotPassword(
      context: state!.context,
      request: requestParams,
    );
    print("idForgot :- $isForgot");
    if (isForgot['code'] == 200) {
      var mail = state!.userEmailController.text;
      Navigator.push(
          state!.context,
          MaterialPageRoute(
            builder: (context) =>
                SentEmailPage(email: mail),
          ));
      state!.setState(() {
        state!.isBtnEnabled = false;
        provider.status = ForgotPasswordStatus.success;
        provider.notifyListeners();
      });
      state!.userEmailController.clear();
    } else {
      state!.setState(() {
        provider.status = ForgotPasswordStatus.failure;
        provider.notifyListeners();
      });
    }
  }
}