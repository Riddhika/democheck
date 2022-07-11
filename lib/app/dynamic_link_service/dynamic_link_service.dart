import 'dart:async';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../pages/login/forgot_password/link_expired_page/link_expired_page.dart';
import '../../pages/login/forgot_password/new_password/new_pass_page.dart';
import '../utils/app_constant.dart';

Future<void> initDynamicLinks(
    {BuildContext? context, Function()? setDuration}) async {
  FirebaseDynamicLinks.instance.onLink;

  // this is called when app is not open in background
  final PendingDynamicLinkData? data =
      await FirebaseDynamicLinks.instance.getInitialLink();
  final Uri deepLink = data!.link;
  print("deepLink $deepLink");
  print("deepLink path-> ${deepLink.path}");
  print("Deeplink Path Token -> ${deepLink.queryParameters['token']}");
  print("Deeplink Path Created -> ${deepLink.queryParameters['created']}");
  String linkToken = deepLink.queryParameters['token']!;
  int created = int.parse(deepLink.queryParameters['created']!);

  final diffrenceMin = dynamicLinkExpiredOrNot(created: created);

  // pinal commit added
  print('Diffrence Miniute - > $diffrenceMin');

  if (diffrenceMin >= 10) {
    print("Background Diffrence Minitues Expired");
    navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) => const LinkExpiredPage(
        )), (route) => false).then((value) => print("navigator2"));
    print("navigator1");
  } else {
    print("Background Diffrence Minitues Not Expired");
    navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) => NewPasswordPage(
          linkToken: linkToken,
        )), (route) => false).then((value) => print("navigator1"));
    print("navigator");
  }
}
