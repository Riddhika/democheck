// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../dash_board_page/dash_board_page.dart';
import 'otp_varify_screen.dart';
import 'otp_verify_provider.dart';
import 'resend_otp_provider.dart';

SharedPreferences? prefs;

class OtpVarifyScreenPageViewModel{
  OtpVarifyScreenState? state;

  OtpVarifyScreenViewModel({OtpVarifyScreenState? state}) {
    this.state = state;
  }

  VerifyOTPProvider verifyOTPProvider = VerifyOTPProvider();
  ResendOtpProvider resendOtpProvider = ResendOtpProvider();
  Future<void> verifyOtpApiCall() async {
    Map requestParams = state!.widget.isEmailChange!
        ? {
      "otp": state!.otpController.text,
      "emailChanged": state!.widget.isEmailChange.toString(),
      "email": state!.widget.email
    }
        : {
      "otp": state!.otpController.text,
    };
    print("VerifyOtp Map -> $requestParams");
    print("IsVerify profile show :- ${state!.isResendText}");
    if (state!.widget.isEmailChange!) {
      final Verifyotp = await verifyOTPProvider.callVerifyOtp(request: requestParams, context: state!.context, token: "Bearer " + state!.widget.token!);
      print("IsVerify profile show :- ${state!.isResendText}");
      if (Verifyotp['code'] == 200) {
        state!.widget.setEmailCall!.call();
        Navigator.pop(state!.context, true);
      } else {
        verifyOTPProvider.status=VerifyOTPStatus.success;
        verifyOTPProvider.notifyListeners();
      }
      state!.setState(() {});
    } else {
      final verifyotp=
      await verifyOTPProvider.callVerifyOtp(request: requestParams, context: state!.context, token: "Bearer " + state!.widget.responseData!.token);
      print("IsVerify show :- ${state!.isResendText}");
      if (verifyotp['code'] == 200) {
        await Navigator.pushReplacement(
            state!.context,
            MaterialPageRoute(
              builder: (context) => DashboardPage(responseData: state!.widget.responseData!,),
            )
        );
      }
    }
  }
  Future<void> resendOtpApiCall(token) async {
    Map<String, String> requestParams = {
      "newEmail": state!.widget.email!,
    };
    final isResend = await resendOtpProvider.callResendOtp(context: state!.context, requestParams: requestParams, token: token);
    if (isResend['code'] == 200) {
      state!.setState(() {
        state!.isResendText = false;
        state!.isLoading = false;
        state!.otpController;
      });
    } else {
      state!.setState(() {
        state!.isResendText = false;
        state!.isLoading = false;
      });
    }
  }
}