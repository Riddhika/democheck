import 'package:flutter/material.dart';

import '../../../../app/utils/app_constant.dart';
import '../../../../app/utils/string_constant.dart';
import '../../../../app/widget/common_appbar.dart';
import '../../../../app/widget/common_button.dart';
import '../../../../app/widget/common_flower_img.dart';
import '../../../../app/widget/common_text.dart';
import '../new_password/new_pass_page.dart';

class SentEmailPage extends StatefulWidget {
  final String email;

  const SentEmailPage({Key? key, required this.email}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SentEmailPageState createState() => _SentEmailPageState();
}

class _SentEmailPageState extends State<SentEmailPage> with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              const CommonAppbar(
                title: StringConstant.forgot_pass,
                isBackOn: false,
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
                          emailSent(),
                          const SizedBox(
                            height: 10.0,
                          ),
                          weHaveEmailSent(),
                          const SizedBox(
                            height: 40.0,
                          ),
                          okButtonField(),
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

  Widget emailSent() {
    return Align(
      alignment: Alignment.topLeft,
      child: CommonText(
        StringConstant.send_email,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        fontFamily: AppConstant.font_lato,
        color: AppConstant.colorTextBlack,
      ),
    );
  }

  Widget weHaveEmailSent() {
    return Align(
      alignment: Alignment.topLeft,
      child: CommonText(
        "${StringConstant.send_text_email} ${widget.email} ${StringConstant.posted_text}",
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: AppConstant.font_barndon,
        color: AppConstant.colorTextBlack,
      ),
    );
  }

  Widget okButtonField() {
    return SizedBox(
      width: double.infinity,
      child: CommonButton(
        borderRadius: 25.0,
        elevation: 0.0,
        buttonType: ButtonType.ElevatedButton,
        onPressed: () {
       Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NewPasswordPage(email: widget.email,),
              ));
        },
        color: AppConstant.colorPrimary,
        child: CommonText(
          StringConstant.ok_text,
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
          fontFamily: AppConstant.font_barndon,
        ),
      ),
    );
  }
}
