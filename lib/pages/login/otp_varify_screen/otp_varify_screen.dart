import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_structure/app/utils/app_constant.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../app/utils/string_constant.dart';
import '../../../app/widget/common_appbar.dart';
import '../../../app/widget/common_button.dart';
import '../../../app/widget/common_flower_img.dart';
import '../../../app/widget/common_indicator.dart';
import '../../../app/widget/common_text.dart';
import '../register/register_model.dart';
import 'otp_varify_screen_viewmodel.dart';

// ignore: must_be_immutable
class OtpVarifyScreen extends StatefulWidget {
  ResponseData? responseData;
  // final bool isBackOn;
  final String? token, email;
  final Function? setEmailCall;
  final bool? isEmailChange;
   OtpVarifyScreen({ Key? key, this.responseData, this.token, this.setEmailCall, this.isEmailChange, this.email}) : super(key: key);

  @override
  OtpVarifyScreenState createState() => OtpVarifyScreenState();
}

class OtpVarifyScreenState extends State<OtpVarifyScreen> with WidgetsBindingObserver{
  OtpVarifyScreenPageViewModel? model;
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  bool isResendText = false;
  bool isBtnEnabled = false;
  bool isLoading = false;
  bool isResend = false;

  @override
  Widget build(BuildContext context) {
    model = OtpVarifyScreenPageViewModel();
    return Scaffold(
        backgroundColor: Colors.white,
        body:SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Stack(
              children: [
                const CommonAppbar(
                  title: StringConstant.otp_verify_text,
                  isBackOn: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90.0, bottom: 10.0),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          confirmationText(),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 45),
                            child: Center(
                              child: Form(
                                key: formKey,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20
                                    ),
                                    child: PinCodeTextField(
                                      appContext: context,
                                      textStyle: const TextStyle(),
                                      pastedTextStyle: const TextStyle(
                                        color: AppConstant.colorWhite,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 20,
                                      ),
                                      length: 6,
                                      obscureText: true,
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(5),
                                        activeColor: AppConstant.colorGrey,
                                        borderWidth: 1.0,
                                        disabledColor: Colors.white,
                                        inactiveColor: AppConstant.colorGrey,
                                        selectedColor: AppConstant.colorPrimary,
                                        inactiveFillColor: Colors.white,
                                        selectedFillColor: AppConstant
                                            .colorWhitePink,
                                        fieldHeight: 30,
                                        fieldWidth: 30,
                                        activeFillColor: Colors.white,
                                      ),
                                      blinkWhenObscuring: true,
                                      animationType: AnimationType.fade,
                                      cursorColor: Colors.white,
                                      animationDuration: const Duration(
                                          milliseconds: 300),
                                      enableActiveFill: true,
                                      errorAnimationController: errorController,
                                      controller: otpController,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      boxShadows: const [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          color: Colors.black12,
                                          blurRadius: 10,
                                        )
                                      ],
                                      onCompleted: (v) {
                                        isBtnEnabled = true;
                                        isResendText = true;
                                        print("Completed");
                                        setState(() {});
                                      },
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          currentText = value;
                                          if(currentText.isEmpty){
                                            isBtnEnabled = false;
                                          }
                                        });
                                      },
                                      beforeTextPaste: (text) {
                                        print("Allowing to paste $text");
                                        return true;
                                      },
                                    )),
                              ),
                            ),
                          ),
                          // otpBoxField(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          progressAndResendText(),
                          const SizedBox(
                            height: 30.0,
                          ),
                          sendAgainButton(),
                          const CommonFlower()
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget confirmationText() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: CommonText(' ${StringConstant.otp_verify_dec_text} ${widget.email}.',
              // ${widget.email}
              textAlign: TextAlign.center,
              fontSize: 14.0,
              fontFamily: AppConstant.font_barndon,
              fontWeight: FontWeight.w400,
              color: AppConstant.colorTextBlack)
      ),
    );
  }

  int count = 0;

  Widget progressAndResendText() {
    print("NEELIMA CODE RUN HERE");
    if (count > 2) {
      return SizedBox(
      height: 10,
      child: InkWell(
        onTap: () {
          print("run type ${count.toString()}");
          setState(() {});
        },
      ),
    );
    } else {
      return Column(
        children: [
          !isResendText?const SizedBox():CommonText("Hast du keinen Code erhalten?"),
          !isResendText
              ? InkWell(
            onTap: () {
              print("run type ${count.toString()}");
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder(
                    tween: Tween(begin: 60.0, end: 0),
                    duration: const Duration(seconds: 60),
                    builder: (context, value, child) =>
                        Center(
                            child: CircularPercentIndicator(
                              radius: 58.0,
                              lineWidth: 6.0,
                              backgroundColor:
                              AppConstant.colorPrimary.withOpacity(0.2),
                              backgroundWidth: 2.0,
                              curve: Curves.linear,
                              // percent: (value!.toDouble() *100) / 6000,
                              center: CommonText(
                                "${value}s",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppConstant.font_barndon,
                                color: AppConstant.colorPrimary,
                              ),
                              progressColor: AppConstant.colorPrimary,
                            )),
                    onEnd: () {
                      setState(() {
                        isResendText = true;
                      });
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          )
              : InkWell(
            onTap: () {
              count = count + 1;
              var token = "Bearer ${widget.token}";
              print("token -> ${token.toString()}");
              model!.resendOtpApiCall(token);
              setState(() {});
            },
            child: CommonText(
              StringConstant.resend_otp_text,
              color: AppConstant.colorPrimary,
              fontSize: 16.0,
              fontFamily: AppConstant.font_barndon,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      );
    }
  }

  Widget sendAgainButton() {
    print("isBtnEnabled :- $isBtnEnabled");
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CommonButton(
        borderRadius: 25.0,
        elevation: 0.0,
        buttonType: ButtonType.ElevatedButton,
        onPressed: isBtnEnabled
            ? () {
          model!.verifyOtpApiCall();
         // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>EmailPassLoginPage()));
        }
            : () {},
        color: isBtnEnabled
            ? AppConstant.colorPrimary
            : AppConstant.colorPrimary.withOpacity(0.3),
        child: CommonText(
          "Weiter",
          fontSize: 16.0,
          fontFamily: AppConstant.font_barndon,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
