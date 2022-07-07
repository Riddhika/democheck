// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/utils/app_constant.dart';
import '../../../app/utils/full_screen_loder.dart';
import '../../../app/utils/image_constant.dart';
import '../../../app/utils/shared_pref.dart';
import '../../../app/utils/string_constant.dart';
import '../../../app/widget/common_image_assets.dart';
import '../../../app/widget/common_login_button.dart';
import '../../../app/widget/common_text.dart';
import '../../dash_board_page/dash_board_page.dart';
import '../email_pass_login/email_pass_login_page.dart';
import 'signin_provider.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    SignInProvider authProvider = Provider.of<SignInProvider>(context);
    switch (authProvider.status) {
      case SignInTypeStatus.failure:
        print("Sign in fail");
        break;
      case SignInTypeStatus.initial:
        print("Sign in canceled");
        break;
      case SignInTypeStatus.success:
        print("Sign in success");
        break;
      default:
        break;
    }

    return Scaffold(
      backgroundColor: AppConstant.colorWhite,
      /*backgroundColor: Colors.pink,*/
      body:SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Consumer<SignInProvider>(builder: (context, p, c) {
            SignInTypeStatus state = p.status;;
            return Stack(
              alignment: Alignment.center,
              children: [
                const CommonImageAsset(
                  image: ImageConstant.ic_singin_page,
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 50),
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                                color: AppConstant.colorWhite,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppConstant.colorBoxShadow,
                                    spreadRadius: 4,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ]),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30.0,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18, right: 18),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CommonText(
                                            StringConstant.free_trial,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13.0,
                                            fontFamily: AppConstant.font_barndon,
                                            color: AppConstant.colorTextBlack),
                                      ),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: InkWell(
                                            onTap: () async{
                                              await setPrefBoolValue(KEY_PUSH_NOTI_ALLOW, true);
                                              await setPrefBoolValue(KEY_AUDIO_ALLOW, true);
                                              // ignore: use_build_context_synchronously
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SignInScreen()));
                                            },
                                            child: CommonText(
                                              StringConstant.register_plan,
                                              color: AppConstant.colorPrimary,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              fontFamily: AppConstant
                                                  .font_barndon,
                                              decoration: TextDecoration
                                                  .underline,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                CommonText(StringConstant.thank_text,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0,
                                    color: AppConstant.colorTextBlack),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                CommonText(
                                  StringConstant.hello_text,
                                  fontFamily: AppConstant.font_playlist,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 42.0,
                                  color: AppConstant.colorTextBlack,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                CommonText(
                                  StringConstant.welcome_text,
                                  fontSize: 14.0,
                                  fontFamily: AppConstant.font_barndon,
                                  fontWeight: FontWeight.w400,
                                  color: AppConstant.colorTextBlack,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                CommonLoginButton(
                                  color: AppConstant.colorBlue,
                                  icon: ImageConstant.ic_fb_login,
                                  text: StringConstant.face_book_login,
                                  onTap: () async {
                                    await setPrefBoolValue(KEY_PUSH_NOTI_ALLOW, true);
                                    await setPrefBoolValue(KEY_AUDIO_ALLOW, true);
                                    await authProvider.signinWithFacebook(state: this);
                                    //model.signInWithFaceBook();
                                  },
                                ),
                                const SizedBox(height: 5.0),
                                CommonLoginButton(
                                  color: AppConstant.colorWhite,
                                  icon: ImageConstant.ic_google_login,
                                  text: StringConstant.google_login,
                                  textColor: AppConstant.colorTextBlack,
                                  border: const BorderSide(
                                      color: AppConstant.colorTextBlack),
                                  onTap: () async {
                                    await setPrefBoolValue(KEY_PUSH_NOTI_ALLOW, true);
                                    await setPrefBoolValue(KEY_AUDIO_ALLOW, true);
                                    await authProvider.signinWithGoogle(state: this);

                                    //model.signInWithGoogle();
                                  },
                                ),
                                Platform.isIOS
                                    ? Column(
                                  children: [
                                    const SizedBox(height: 5.0),
                                    CommonLoginButton(
                                      color: Colors.black,
                                      icon: ImageConstant.ic_apple_login,
                                      text:
                                      StringConstant.apple_login,
                                      textColor: AppConstant.colorWhite,
                                      border: const BorderSide(
                                          color: AppConstant.colorTextBlack),
                                      onTap: () async{
                                        await setPrefBoolValue(KEY_PUSH_NOTI_ALLOW, true);
                                        await setPrefBoolValue(KEY_AUDIO_ALLOW, true);
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DashboardPage()));
                                      },
                                    ),
                                  ],
                                )
                                    : const SizedBox(),
                                const SizedBox(height: 5.0),
                                CommonLoginButton(
                                  color: AppConstant.colorPrimary,
                                  icon: ImageConstant.ic_email_login,
                                  text: StringConstant.email_pass_login,
                                  maxLineText: 2,
                                  textColor: AppConstant.colorWhite,
                                  onTap: ()async{
                                    await setPrefBoolValue(KEY_PUSH_NOTI_ALLOW, true);
                                    await setPrefBoolValue(KEY_AUDIO_ALLOW, true);
                                   // await setPrefBoolValue(KEY_EMAIL_LOGIN, true);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const EmailPassLoginPage(),
                                        ));
                                  },
                                ),
                                const SizedBox(height: 70.0),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: authProvider.status == SignInTypeStatus.waiting
                      ? const FullScreenLoader()
                      : const SizedBox(),
                ),
              ],
            );
           }
          ),
        ),
      ),
    );
  }
}