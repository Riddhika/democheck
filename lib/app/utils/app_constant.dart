// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../main.dart';
import '../../pages/login/sign_in/signin.dart';
import 'shared_pref.dart';

class AppConstant{

  static const String font_barndon = 'Brandon';
  static const String font_playlist = 'Playlist';
  static const String font_lato = 'Lato';
  static const String font_lora = 'Lora';


  //TODO colors
  static const Color colorPrimary = Color(0xFFB07B8B);
  static const Color colorTextBlack = Color(0xFF3C3C3C);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorDivider = Color(0xFF979797);
  static const Color colorBoxShadow = Color(0x1F6D6B6B);
  static const Color colorBlue = Color(0xFF3B5998);
  static const Color colorGrey = Color(0xFF878787);
  static const Color colorError = Color(0xFFE30613);
  static const Color colorWhitePink = Color(0xFFFCF2F4);
}

openKeyBoard({BuildContext? context}) {
  FocusScope.of(context!).requestFocus(FocusNode());
  // SystemChannels.textInput.invokeMethod('TextInput.hide');
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

opHeaderColor({Color? color}){
  return SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor:color,
    statusBarBrightness: Brightness.dark,
  ));
}

dynamicLinkExpiredOrNot({int? created}) {
  var currentTime = DateTime.now();
  var createdDate = DateTime.fromMillisecondsSinceEpoch(created! * 1000);
  final diffrenceMin = currentTime.difference(createdDate).inMinutes;

  print("Current Time :- $currentTime");
  print("Link in Created Date TimeStamp :- $created");
  print("Link Timestamp to Date convert :- $createdDate");
  print("Diffrence Min  :- $createdDate");

  return diffrenceMin;
}


getIntroPage(BuildContext context) async {
  bool isIntroSeen = await getPrefBoolValue(KEY_INTRO);
  if (isIntroSeen) {
   /* navigatorKey.currentState.pushReplacement(MaterialPageRoute(
        builder: (context) => SettingOptionPage(
          title: S.of(context).dataCollectionText,
          isFirstTime: true,
        )));*/
  } else {
    navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
      builder: (context) => const SignInScreen(),
    ));
  }
}