import 'package:flutter/material.dart';
import '../new_pass_set_done/new_pass_set_done.dart';
import 'new_pass_page.dart';
import 'new_pass_page_provider.dart';

class NewPasswordPageViewModel {
  NewPasswordPageState? state;

  NewPasswordPageViewModel({NewPasswordPageState? state}) {
    this.state = state!;
  }
  ResetPasswordProvider provider = ResetPasswordProvider();

  Future<void> resetPasswordApiCall() async {
    // ignore: invalid_use_of_protected_member
    state!.setState(() {
      state!.isLoading = true;
    });
    Map requestParams = {
      "token": state!.widget.linkToken,
      "password": state!.passController.text,
    };
    var reserpass = await provider.callResetPassword(
      context: state!.context,
      request: requestParams,
    );
    print("isReset -> $reserpass");
    print("isReset1 -> ${reserpass['code']}");
    if (reserpass != null && reserpass['code'] == 200) {
      state!.isLoading = false;
      Navigator.pushReplacement(state!.context, MaterialPageRoute(builder: (context) => const NewPassSetDone(),));
      // ignore: invalid_use_of_protected_member
      state!.setState(() {});
    } else {
      print("isReset1 -> ${reserpass['code']}");
    }
  }
}