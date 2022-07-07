import 'package:flutter/material.dart';
import '../../../app/utils/app_constant.dart';
import '../../../app/utils/string_constant.dart';
import '../../../app/widget/common_appbar.dart';
import '../../../app/widget/common_button.dart';
import '../../../app/widget/common_flower_img.dart';
import '../../../app/widget/common_text.dart';
import '../../../app/widget/common_textfield.dart';
import 'forgot_password_viewmodel.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  ForgotPasswordViewModel? model;
  TextEditingController userEmailController = TextEditingController();
  int created = 0;
  String linkToken = '';
  String email = "", error = "", errorEmail = "";

  bool isLoading = false,
      isFailed = false,
      isBtnEnabled = false,
      isEmailFill = false,
      isEmailValid = false,
      isErrorEmail = false;

  void checkBtnEnabled() {
    if (email.isNotEmpty) {
      isBtnEnabled = true;
    } else {
      isBtnEnabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    model=ForgotPasswordViewModel(state: this);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              const CommonAppbar(
                title: StringConstant.forgot_pass_text,
                isBackOn: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 10.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          forgotPassText(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          sendLinkText(),
                          const SizedBox(
                            height: 10.0,
                          ),
                          _emailField(),
                          _errorEmailText(),
                          const SizedBox(
                            height: 10.0,
                          ),
                          errorText(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          sendButtonField(),
                          const CommonFlower()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget forgotPassText() {
    return Align(
      alignment: Alignment.topLeft,
      child: CommonText(StringConstant.forgot_pass_nopro_text,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        fontFamily: AppConstant.font_lato,
        color: AppConstant.colorTextBlack,
      ),
    );
  }

  Widget sendLinkText() {
    return CommonText(
      StringConstant.send_link_desc,
      fontSize: 14.0,
      fontFamily: AppConstant.font_barndon,
      color: AppConstant.colorTextBlack,
      fontWeight: FontWeight.w400,
    );
  }

  Widget _emailField() {
    return CommonTextField(
      alignment: Alignment.centerLeft,
      controller: userEmailController,
      text: StringConstant.user_name,
      inputType: TextInputType.emailAddress,
      onChanged: (val) {
        setState(() {
          email = val;
          checkBtnEnabled();
        });
      },
      onTap: () {
        setState(() {
          isEmailFill = true;
        });
      },
      isFill: isEmailFill,
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
            errorEmail,
            color: AppConstant.colorError,
          ),
        ],
      ),
    );
  }

  Widget errorText() {
    return isFailed
        ? Align(
      alignment: Alignment.centerLeft,
      child: CommonText(
        error,
        color: AppConstant.colorError,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
    )
        : Container();
  }

  Widget sendButtonField() {
    return SizedBox(
      width: double.infinity,
      child: CommonButton(
        borderRadius: 25.0,
        elevation: 0.0,
        buttonType: ButtonType.ElevatedButton,
        onPressed: isBtnEnabled
            ? () {
          model!.forgotPasswordApiCall();
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>SentEmailPage()));
        }
            : () {},
        color: isBtnEnabled
            ? AppConstant.colorPrimary
            : AppConstant.colorPrimary.withOpacity(0.3),
        child: CommonText(StringConstant.send_text,
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
          fontFamily: AppConstant.font_barndon,
        ),
      ),
    );
  }
}
