import 'package:flutter/material.dart';
import '../../../../app/utils/app_constant.dart';
import '../../../../app/utils/string_constant.dart';
import '../../../../app/widget/common_appbar.dart';
import '../../../../app/widget/common_button.dart';
import '../../../../app/widget/common_flower_img.dart';
import '../../../../app/widget/common_text.dart';
import '../../email_pass_login/email_pass_login_page.dart';

class NewPassSetDone extends StatefulWidget {
  const NewPassSetDone({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewPassSetDoneState createState() => _NewPassSetDoneState();
}

class _NewPassSetDoneState extends State<NewPassSetDone>  with WidgetsBindingObserver {
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
                          passwordsave(),
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

  Widget passwordsave() {
    return Align(
      alignment: Alignment.topLeft,
      child: CommonText(StringConstant.pass_saved,
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
                builder: (context) => const EmailPassLoginPage(),
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