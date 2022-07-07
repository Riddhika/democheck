import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_structure/app/widget/common_button.dart';
import '../../../../app/utils/app_constant.dart';
import '../../../../app/utils/image_constant.dart';
import '../../../../app/utils/string_constant.dart';
import '../../../../app/widget/common_appbar.dart';
import '../../../../app/widget/common_flower_img.dart';
import '../../../../app/widget/common_pass_validation.dart';
import '../../../../app/widget/common_text.dart';
import '../../../../app/widget/common_textfield.dart';
import 'new_pass_page_viewmodel.dart';

class NewPasswordPage extends StatefulWidget {
  final String? linkToken;
  final String? email;
  const NewPasswordPage({Key? key, this.email, this.linkToken}) : super(key: key);
  @override
  NewPasswordPageState createState() => NewPasswordPageState();
}

class NewPasswordPageState extends State<NewPasswordPage> {
  NewPasswordPageViewModel? model;
  TextEditingController passController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool isFocus = false;

  String? password, repeatPassword;

  bool isBtnEnabled = false;

  bool isTwelDone = false,
      isSmallDone = false,
      isCapitalDone = false,
      isNumberDone = false,
      isSpecialDone = false;
  bool minPassChar = false,
      upperCaseChar = false,
      lowerCaseChar = false,
      numberCaseChar = false,
      specialCaseChar = false;
  bool isLoading = false,
      isFailedPass = false;
  bool isPassFill = false,
      isRepeatPassFill = false;

  void validationPassword() {
    //TODO AT LEAST 12 CHAR
    minPassChar = password!.contains(RegExp(r'.{12,}'), 0);
    if (minPassChar) {
      isTwelDone = true;
    } else {
      isTwelDone = false;
    }

    //TODO AT LEAST 1 SMALL LATTER
    lowerCaseChar = password!.contains(RegExp(r'[a-z]'), 0);
    if (lowerCaseChar) {
      isSmallDone = true;
    } else {
      isSmallDone = false;
    }

    //TODO AT LEAST 1 CAPITAL LETTER
    upperCaseChar = password!.contains(RegExp(r'[A-Z]'), 0);
    if (upperCaseChar) {
      isCapitalDone = true;
    } else {
      isCapitalDone = false;
    }

    //TODO AT LEAST 1 NUMBER CHAR
    numberCaseChar = password!.contains(RegExp(r'[0-9]'), 0);
    if (numberCaseChar) {
      isNumberDone = true;
    } else {
      isNumberDone = false;
    }

    //TODO AT LEAST 1 SPECIAL CHAR
    specialCaseChar = password!.contains(RegExp(r'[!@#\$&*~]'), 0);
    if (specialCaseChar) {
      isSpecialDone = true;
    } else {
      isSpecialDone = false;
    }
  }

  void checkRegBtnEnabled() {
    if (minPassChar && upperCaseChar && lowerCaseChar && numberCaseChar &&
        specialCaseChar) {
      if (password!.isNotEmpty &&
          repeatPassword!.isNotEmpty && repeatPassword == password) {
        isBtnEnabled = true;
      } else {
        isBtnEnabled = false;
      }
    } else {
      isBtnEnabled = false;
    }
  }
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    model = NewPasswordPageViewModel(state: this);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              const CommonAppbar(
                title: StringConstant.new_pass_text,
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
                          _setnewpass(),
                          const SizedBox(
                            height: 18.0,
                          ),
                          _passwordField(),
                          const SizedBox(
                            height: 10.0,
                          ),
                          _repeatPasswordField(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          isFocus || passController.text.isNotEmpty
                              ? CommonPassValidation(
                            validationTitle: StringConstant
                                .at_least_twelve_char,
                            isDone: isTwelDone,
                          )
                              : const SizedBox(),
                          isFocus || passController.text.isNotEmpty
                              ? const SizedBox(
                            height: 10.0,
                          )
                              : const SizedBox(),
                          isFocus || passController.text.isNotEmpty
                              ? CommonPassValidation(
                            validationTitle: StringConstant
                                .at_least_one_small_char,
                            isDone: isSmallDone,
                          )
                              : const SizedBox(),
                          isFocus || passController.text.isNotEmpty
                              ? const SizedBox(
                            height: 10.0,
                          )
                              : const SizedBox(),
                          isFocus || passController.text.isNotEmpty
                              ? CommonPassValidation(
                            validationTitle: StringConstant
                                .at_least_one_capital_char,
                            isDone: isCapitalDone,
                          )
                              : const SizedBox(),
                          isFocus || passController.text.isNotEmpty
                              ? const SizedBox(
                            height: 10.0,
                          )
                              : const SizedBox(),
                          isFocus || passController.text.isNotEmpty
                              ? CommonPassValidation(
                            validationTitle: StringConstant.at_least_one_num,
                            isDone: isNumberDone,
                          )
                              : const SizedBox(),
                          isFocus || passController.text.isNotEmpty
                              ? const SizedBox(
                            height: 10.0,
                          )
                              : const SizedBox(),
                          isFocus || passController.text.isNotEmpty
                              ? CommonPassValidation(
                            validationTitle: StringConstant
                                .at_least_one_spc_char,
                            isDone: isSpecialDone,
                          )
                              : const SizedBox(),
                          isFocus || passController.text.isNotEmpty
                              ? const SizedBox(
                            height: 10.0,
                          )
                              : const SizedBox(),
                          saveonComputerbtn(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const CommonFlower()
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _setnewpass() {
    return Align(
      alignment: Alignment.topLeft,
      child: CommonText(
        StringConstant.set_new_pass_desc,
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        fontFamily: AppConstant.font_lato,
        color: AppConstant.colorTextBlack,
      ),
    );
  }

  Widget _passwordField() {
    return CommonTextField(
      alignment: Alignment.centerLeft,
      controller: passController,
      obsecureText: _obscureText,
      inputType: TextInputType.text,
      text: StringConstant.new_pass_text,
      iconSuffix: Image.asset(
        _obscureText ? ImageConstant.ic_pass_hide : ImageConstant.ic_pass_show,
        height: 22.0,
        width: 22.0,
      ),
      onSuffixTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      onTap: () {
        setState(() {
          isFocus = true;
          isPassFill = true;
          isRepeatPassFill = false;
        });
      },
      isFill: isPassFill,
      validator: (val) {
        if (val!.isEmpty) return 'Please Enter Password';
        return null;
      },
      onChanged: (val) {
        setState(() {
          password = val;
          validationPassword();
          checkRegBtnEnabled();
        });
      },
    );
  }

  Widget _repeatPasswordField() {
    return CommonTextField(
      alignment: Alignment.centerLeft,
      controller: repeatPassController,
      obsecureText: _obscureText1,
      text: StringConstant.repeat_new_pass,
      inputType: TextInputType.visiblePassword,
      onTap: () {
        setState(() {
          isFocus = false;
          isPassFill = false;
          isRepeatPassFill = true;
        });
      },
      isFill: isRepeatPassFill,
      iconSuffix: Image.asset(
        _obscureText1 ? ImageConstant.ic_pass_hide : ImageConstant.ic_pass_show,
        height: 22.0,
        width: 22.0,
      ),
      onSuffixTap: () {
        setState(() {
          _obscureText1 = !_obscureText1;
        });
      },
      onChanged: (val) {
        setState(() {
          repeatPassword = val;
          checkRegBtnEnabled();
        });
      },
    );
  }

  Widget saveonComputerbtn() {
    return SizedBox(
      width: double.infinity,
      child: CommonButton(
        borderRadius: 25.0,
        elevation: 0.0,
        buttonType: ButtonType.ElevatedButton,
        onPressed: isBtnEnabled
            ? () {
              model!.resetPasswordApiCall();
             }
            : () {},
        color: isBtnEnabled
            ? AppConstant.colorPrimary
            : AppConstant.colorPrimary.withOpacity(0.3),
        child: CommonText(StringConstant.save_on_com,
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
          fontFamily: AppConstant.font_barndon,
        ),
      ),
    );
  }
}
