import 'package:flutter/material.dart';
import 'package:flutter_mvvm_structure/app/utils/app_constant.dart';
import '../utils/image_constant.dart';
import '../utils/string_constant.dart';
import 'common_image_assets.dart';
import 'common_rich_text.dart';

class CommonPrivacyTermsCondition extends StatelessWidget {

  final bool? checkPrivacy;

  const CommonPrivacyTermsCondition({Key? key, this.checkPrivacy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        checkPrivacy!
            ? const Align(
          alignment: Alignment.centerLeft,
          child: CommonImageAsset(
            image: ImageConstant.ic_check,
            height: 24.0,
            width: 24.0,
          ),
        )
            : const Align(
          alignment: Alignment.centerLeft,
          child: CommonImageAsset(
            image: ImageConstant.ic_uncheck,
            height: 24.0,
            width: 24.0,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 8.0),
            child: CommonRichText(
              firstText: StringConstant.i_have_text,
              firstTextStyle: const TextStyle(
                  fontSize: 13.5,
                  color: AppConstant.colorTextBlack,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppConstant.font_barndon),
              secondText:"${StringConstant.privacy_police},\n",
              secondTextStyle: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w400,
                  fontFamily:AppConstant.font_barndon,
                  color: AppConstant.colorPrimary),
              secondTextTap: () {
              },
              second1Text:StringConstant.teams_and_con,
              second1TextStyle: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w400,
                  fontFamily:  AppConstant.font_barndon,
                  color: AppConstant.colorPrimary),
              second1TextTap: () {
              },
              thirdText:StringConstant.read_and_accept,
              thirdTextStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: AppConstant.font_barndon,
                  color: AppConstant.colorTextBlack),
            ),
          ),
        ),
      ],
    );
  }
}