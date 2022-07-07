import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../app/utils/shared_pref.dart';
import '../../dash_board_page/dash_board_page.dart';
import '../register/register.dart';
import 'email_pass_login_page.dart';
FirebaseFirestore? firebaseFirestore;
class EmailPassLoginPageViewModel{
  EmailPassLoginPageState? state;
  EmailPassLoginPageViewModel({EmailPassLoginPageState? state}) {
    this.state = state!;
  }

 Future signInwithEmail()async{
    try {
      final newUser = await state!.auth.signInWithEmailAndPassword(
          email: state!.email!, password: state!.password!);
      print(newUser.toString());
      // ignore: unnecessary_null_comparison
      if (newUser != null) {
        await setPrefBoolValue(KEY_EMAIL_LOGIN, true);
        Navigator.pushReplacement(
            state!.context,
            MaterialPageRoute(builder: (context) => const DashboardPage()));
      }
      else{
        Navigator.pushReplacement(
            state!.context,
            MaterialPageRoute(builder: (context) => const RegisterPage()));
      }
    } catch (e) {
      print("ERROR GET IN EMAIL PASSWORD PAGE====>$e");
    }
  }
}