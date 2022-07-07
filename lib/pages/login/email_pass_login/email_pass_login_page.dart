import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../app/utils/app_constant.dart';
import '../../../app/utils/image_constant.dart';
import '../../../app/utils/string_constant.dart';
import '../../../app/widget/common_button.dart';
import '../../../app/widget/common_flower_img.dart';
import '../../../app/widget/common_image_assets.dart';
import '../../../app/widget/common_rich_text.dart';
import '../../../app/widget/common_text.dart';
import '../../../app/widget/common_textfield.dart';
import '../forgot_password/forgot_password.dart';
import '../register/register.dart';
import '../sign_in/signin.dart';
import 'email_pass_login_viewmodel.dart';

class EmailPassLoginPage extends StatefulWidget {
  const EmailPassLoginPage({Key? key}) : super(key: key);

  @override
  EmailPassLoginPageState createState() => EmailPassLoginPageState();
}

class EmailPassLoginPageState extends State<EmailPassLoginPage> {
  final _formkey = GlobalKey<FormState>();
  EmailPassLoginPageViewModel? model;
  bool isBtnEnabled = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String? email,
          password,
          errorEmail = "";
  bool isEmailFill = false,
      isPassFill = false,
      isErrorEmail = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    model = EmailPassLoginPageViewModel(state: this);
    return Scaffold(
      backgroundColor: AppConstant.colorWhite,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Form(
              key: _formkey,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (c) => const SignInScreen()),
                                    (route) => false);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0,
                                horizontal: 20.0),
                            child: CommonImageAsset(
                              image: ImageConstant.ic_back_btn,
                              height: 18.0,
                              width: 16.0,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: CommonText(StringConstant.login_text,
                              fontSize: 26.0,
                              fontFamily: AppConstant.font_playlist,
                              fontWeight: FontWeight.w400,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 40.0,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                _emailField(),
                                _errorEmailText(),
                                _passwordField(),
                                _forgotField(),
                                _loginButton(),
                                const SizedBox(height: 10.0,),
                                _loginHereField(),
                                _privacyandimprintField(),
                                const CommonFlower()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return CommonTextField(
      alignment: Alignment.centerLeft,
      inputType: TextInputType.emailAddress,
      onChanged: (val) {
        setState(() {
          email = val;
          if (email!.isNotEmpty &&
              password!.isNotEmpty) {
            isBtnEnabled = true;
          } else {
            isBtnEnabled = false;
            isErrorEmail = false;
          }
        });
      },
      onTap: () {
        setState(() {
          isPassFill = false;
          isEmailFill = true;
        });
      },
      isFill: isEmailFill,
      controller: _emailController,
      text: StringConstant.user_name,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _errorEmailText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          const SizedBox(
            height: 5.0,
          ),
          CommonText(
            errorEmail!,
            color: AppConstant.colorError,
          ),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return CommonTextField(
      alignment: Alignment.centerLeft,
      onChanged: (val) {
        setState(() {
          password = val;
          if (email!.isNotEmpty &&
              password!.isNotEmpty) {
            isBtnEnabled = true;
          } else {
            isBtnEnabled = false;
          }
        });
      },
      onTap: () {
        setState(() {
          isEmailFill = false;
          isPassFill = true;
        });
      },
      isFill: isPassFill,
      controller: _passwordController,
      obsecureText: _obscureText,
      text: StringConstant.pass_word,
      iconSuffix: Image.asset(
        // Based on passwordVisible state choose the icon
        _obscureText ? ImageConstant.ic_pass_hide : ImageConstant.ic_pass_show,
        height: 22.0,
        width: 22.0,
      ),
      onSuffixTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      validator: (val) {
        if (val!.isEmpty) return 'Bitte Passwort eingeben';
        return null;
      },
    );
  }

  Widget _forgotField() {
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: InkWell(
            child: CommonText(StringConstant.forgot_pass,
              decoration: TextDecoration.underline,
              fontSize: 16.0,
              fontFamily: AppConstant.font_barndon,
              color: AppConstant.colorPrimary,
              fontWeight: FontWeight.w400,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ForgotPassword()));
            },
          ),
        ));
  }

  Widget _loginButton() {
    return Container(
        margin: const EdgeInsets.only(top: 22.0),
        width: double.infinity,
        child: CommonButton(
          buttonType: ButtonType.ElevatedButton,
          onPressed: isBtnEnabled
              ? () async {
            model!.signInwithEmail();
          }
              : () {},
          elevation: 0.0,
          color: isBtnEnabled ? AppConstant.colorPrimary : AppConstant
              .colorPrimary.withOpacity(0.3),
          borderRadius: 25.0,
          child: CommonText(StringConstant.login_text,
            fontSize: 16.0,
            fontFamily: AppConstant.font_barndon,
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  Widget _loginHereField() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 35.0),
        child: CommonRichText(
          firstText: StringConstant.free_trial_ten_day,
          firstTextStyle: const TextStyle(fontSize: 16.0,
              color: AppConstant.colorTextBlack,
              fontWeight: FontWeight.w400,
              fontFamily: AppConstant.font_barndon),
          secondText: StringConstant.sign_up_for_trial,
          secondTextStyle: const TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w400,
              fontFamily: AppConstant.font_barndon,
              color: AppConstant.colorPrimary),
          secondTextTap: () {
            openKeyBoard(context: context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterPage()));
          },
          second1Text: "",
        ));
  }

  Widget _privacyandimprintField() {
    return Container(
      margin: const EdgeInsets.only(top: 80.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ImprintPage()));
              openKeyBoard(context: context);
            },
            child: CommonText(StringConstant.teams_and_con,
              fontSize: 16.0,
              fontFamily: AppConstant.font_barndon,
              fontWeight: FontWeight.w400,
              color: AppConstant.colorPrimary,
              decoration: TextDecoration.underline,
            ),
          ),
          InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndUsePage()));
              openKeyBoard(context: context);
            },
            child: CommonText(StringConstant.privacy_text,
              fontSize: 16.0,
              fontFamily: AppConstant.font_barndon,
              fontWeight: FontWeight.w400,
              color: AppConstant.colorPrimary,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}


