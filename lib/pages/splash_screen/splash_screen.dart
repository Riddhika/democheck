import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/utils/app_constant.dart';
import '../../app/utils/image_constant.dart';
import '../../app/utils/shared_pref.dart';
import '../../app/widget/common_image_assets.dart';
import '../../variant/app_config.dart';
import '../dash_board_page/dash_board_page.dart';
import '../login/sign_in/signin.dart';
import 'splash_screen_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashScreenViewModel? model;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), (){
      SharedPreferences.getInstance().then((value) async {
        if(value.containsKey(KEY_INTRO)){
          if(value.getBool(KEY_INTRO)!){
            checkSignedIn();
          }
        }else{
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) =>
          // );
        }
      });
    });
  }

  void checkSignedIn() async {
    SharedPreferences.getInstance().then((value) async {
      if(value.containsKey(KEY_SOCIAL_LOGIN)) {
        if (value.getBool(KEY_SOCIAL_LOGIN)!) {
            await setPrefBoolValue(KEY_PUSH_NOTI_ALLOW, true);
            await setPrefBoolValue(KEY_AUDIO_ALLOW, true);
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardPage()),
            );
          }
      }
      else if(value.containsKey(KEY_EMAIL_LOGIN)){
        if (value.getBool(KEY_EMAIL_LOGIN)!) {
          await setPrefBoolValue(KEY_PUSH_NOTI_ALLOW, true);
          await setPrefBoolValue(KEY_AUDIO_ALLOW, true);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardPage()),
          );
        }
      }
      else {
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  const SignInScreen()),);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    model = SplashScreenViewModel(state: this);
    print("BUILD VARIANT BASE_URL=====>${ConstantEnvironment.baseUrl}");
    print("BUILD VARIANT BASE_NEW_URL=====>${ConstantEnvironment.baseNewUrl}");
    print("BUILD VARIANT BASE_URL1=====>${ConstantEnvironment.baseUrl1}");
    return Scaffold(
      backgroundColor: AppConstant.colorWhite,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: const [
            CommonImageAsset(image: ImageConstant.ic_splashImages,
              height: double.infinity,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
