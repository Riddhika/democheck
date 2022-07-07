import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/utils/app_constant.dart';
import '../../../app/utils/full_screen_loder.dart';
import '../../../app/utils/image_constant.dart';
import '../../../app/utils/string_constant.dart';
import '../../../app/widget/common_appbar.dart';
import '../../../app/widget/common_button.dart';
import '../../../app/widget/common_pass_validation.dart';
import '../../../app/widget/common_privacy_tem_condition.dart';
import '../../../app/widget/common_text.dart';
import '../../../app/widget/common_textfield.dart';
import 'register_provider.dart';
import 'register_viewmodel.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  RegisterPageViewModel? model;
  final _pageKey = GlobalKey<ScaffoldState>();
  String platformVersionnew = 'Unknown';
  TextEditingController usernameController = TextEditingController();
  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();

  bool _obscureText = true;
  bool _obscureText1 = true;
  bool isFocus = false;
  bool _valuePrivacy = false;
  bool submitValid = false;


  late String name,
              email,
              password,
              repeatPassword,
              errorEmail = "",
              firstName,
              lastName;

  bool checkPrivacyTerms = false;

  bool isBtnEnabled = false,
      isErrorEmail = false,
      isEmailValid = false;

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
  bool isNameFill = false,
      isFirstNameFill = false,
      isLastNameFill = false,
      isEmailFill = false,
      isPassFill = false,
      isRepeatPassFill = false;

  void validationPassword() {
    //TODO AT LEAST 12 CHAR
    minPassChar = password.contains(RegExp(r'.{12,}'), 0);
    if (minPassChar) {
      isTwelDone = true;
    } else {
      isTwelDone = false;
    }

    //TODO AT LEAST 1 SMALL LATTER
    lowerCaseChar = password.contains(RegExp(r'[a-z]'), 0);
    if (lowerCaseChar) {
      isSmallDone = true;
    } else {
      isSmallDone = false;
    }

    //TODO AT LEAST 1 CAPITAL LETTER
    upperCaseChar = password.contains(RegExp(r'[A-Z]'), 0);
    if (upperCaseChar) {
      isCapitalDone = true;
    } else {
      isCapitalDone = false;
    }

    //TODO AT LEAST 1 NUMBER CHAR
    numberCaseChar = password.contains(RegExp(r'[0-9]'), 0);
    if (numberCaseChar) {
      isNumberDone = true;
    } else {
      isNumberDone = false;
    }

    //TODO AT LEAST 1 SPECIAL CHAR
    specialCaseChar = password.contains(RegExp(r'[!@#\$&*~]'), 0);
    if (specialCaseChar) {
      isSpecialDone = true;
    } else {
      isSpecialDone = false;
    }
  }

  void checkRegBtnEnabled() {
    if (minPassChar && upperCaseChar && lowerCaseChar && numberCaseChar &&
        specialCaseChar) {
      if (checkPrivacyTerms &&
          name.isNotEmpty &&
          firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          repeatPassword.isNotEmpty && repeatPassword == password) {
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
    model = RegisterPageViewModel();
    return ChangeNotifierProvider<RegisterProvider>(
        create: (context) => RegisterProvider(),
    child:Scaffold(
      key: _pageKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child:  Consumer<RegisterProvider>(builder: (context, value, c) {
            print("p -> " + value.status.toString());
            RegisterStatus state = value.status;
            print("STATUS OF P1 -> " +state.toString());
            return Stack(
            children: [
              const CommonAppbar(
                title: StringConstant.register_text,
                isBackOn: true,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: ListView(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              _firstNameField(),
                              const SizedBox(
                                height: 10.0,
                              ),
                              _lastNameField(),
                              const SizedBox(
                                height: 10.0,
                              ),
                              _userNameField(),
                              const SizedBox(
                                height: 10.0,
                              ),
                              _emailField(),
                              isErrorEmail ? _errorEmailText() : Container(),
                              const SizedBox(
                                height: 10.0,
                              ),
                              _passwordField(),
                              const SizedBox(
                                height: 10.0,
                              ),
                              _repeatPasswordField(),
                              const SizedBox(
                                height: 5.0,
                              ),
                              passwordMissMatch(),
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
                              _privacyTermsCheckBox(),
                              const SizedBox(
                                height: 20.0,
                              ),
                              _registerButton(value),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Positioned(
                child: value.status == RegisterStatus.waiting
                    ? const FullScreenLoader()
                    : const SizedBox(),
              ),
            ],
            );}
          ),
        ),
      ),
    )
    );
  }

  Widget _firstNameField() {
    return CommonTextField(
      alignment: Alignment.centerLeft,
      controller: fnController,
      text: StringConstant.first_name,
      textInputAction: TextInputAction.next,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Please Enter First Name';
        }
        return null;
      },
      onChanged: (val) {
        setState(() {
          firstName = val;
          checkRegBtnEnabled();
        });
      },
      onTap: () {
        setState(() {
          isFocus = false;
          isEmailFill = false;
          isPassFill = false;
          isRepeatPassFill = false;
          isNameFill = false;
          isLastNameFill = false;
          isFirstNameFill = true;
        });
      },
      isFill: isFirstNameFill,
    );
  }

  Widget _lastNameField() {
    return CommonTextField(
      alignment: Alignment.centerLeft,
      controller: lnController,
      text: StringConstant.last_name,
      textInputAction: TextInputAction.next,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Please Enter Last Name';
        }
        return null;
      },
      onChanged: (val) {
        setState(() {
          lastName = val;
          checkRegBtnEnabled();
        });
      },
      onTap: () {
        setState(() {
          isFocus = false;
          isEmailFill = false;
          isPassFill = false;
          isRepeatPassFill = false;
          isNameFill = false;
          isFirstNameFill = false;
          isLastNameFill = true;
        });
      },
      isFill: isLastNameFill,
    );
  }

  Widget _userNameField() {
    return CommonTextField(
      alignment: Alignment.centerLeft,
      controller: usernameController,
      text: StringConstant.user_name_reg,
      textInputAction: TextInputAction.next,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Please Enter User Name';
        }
        return null;
      },
      onChanged: (val) {
        setState(() {
          name = val;
          checkRegBtnEnabled();
        });
      },
      onTap: () {
        setState(() {
          isFocus = false;
          isEmailFill = false;
          isPassFill = false;
          isRepeatPassFill = false;
          isFirstNameFill = false;
          isLastNameFill = false;
          isNameFill = true;
        });
      },
      isFill: isNameFill,
    );
  }

  Widget _emailField() {
    return CommonTextField(
      alignment: Alignment.centerLeft,
      controller: emailController,
      text: StringConstant.user_name,
      textInputAction: TextInputAction.next,
      onTap: () {
        setState(() {
          isFocus = false;
          isPassFill = false;
          isRepeatPassFill = false;
          isNameFill = false;
          isFirstNameFill = false;
          isLastNameFill = false;
          isEmailFill = true;
        });
      },
      isFill: isEmailFill,
      onChanged: (val) {
        setState(() {
          email = val;
          checkRegBtnEnabled();
        });
      },
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

  Widget _passwordField() {
    return CommonTextField(
      alignment: Alignment.centerLeft,
      controller: passController,
      obsecureText: _obscureText,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      text: StringConstant.pass_word,
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
          isEmailFill = false;
          isPassFill = true;
          isRepeatPassFill = false;
          isNameFill = false;
          isFirstNameFill = false;
          isLastNameFill = false;
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
      text: StringConstant.repeat_pass,
      inputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onTap: () {
        setState(() {
          isFocus = false;
          isEmailFill = false;
          isPassFill = false;
          isRepeatPassFill = true;
          isNameFill = false;
          isFirstNameFill = false;
          isLastNameFill = false;
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

  Widget passwordMissMatch() {
    return isFailedPass
        ? Align(
      alignment: Alignment.centerLeft,
      child: CommonText(
        StringConstant.same_as_pass,
        color: AppConstant.colorError,
        fontSize: 14.0,
      ),
    )
        : const SizedBox();
  }

  Widget _privacyTermsCheckBox() {
    return InkWell(
        onTap: () {
          setState(() {
            _valuePrivacy = !_valuePrivacy;
            checkPrivacyTerms = _valuePrivacy;
            checkRegBtnEnabled();
          });
        },
        child: CommonPrivacyTermsCondition(
          checkPrivacy: checkPrivacyTerms,
        ));
  }

  Widget _registerButton(provider) {
    return SizedBox(
        width: double.infinity,
        child: CommonButton(
          buttonType: ButtonType.ElevatedButton,
          onPressed: isBtnEnabled
              ? () async {
            try {
              model!.RegisterPageLogin(provider);
              /* if(user!=null) {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVarifyScreen()));
              }*/
            } catch (e) {
              print("ERROR GET IN REGISTER PAGE====>$e");
            }
          }
              : () {},
          elevation: 0.0,
          color: isBtnEnabled ? AppConstant.colorPrimary : AppConstant
              .colorPrimary.withOpacity(0.3),
          borderRadius: 25.0,
          child: CommonText(StringConstant.register_text,
            fontSize: 16.0,
            fontFamily: AppConstant.font_barndon,
            fontWeight: FontWeight.w700,
          ),
        ));
  }
}
