import 'package:flutter/material.dart';
import '../utils/app_constant.dart';
import '../utils/image_constant.dart';
import 'common_image_assets.dart';
import 'common_text.dart';

class CommonTitleUnderline extends StatelessWidget {
  final String? title;
  final Color? color;
  final double? underlineHeight, underlineWidth;

  const CommonTitleUnderline({Key? key, this.title, this.color, this.underlineHeight=10.0, this.underlineWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30.0,
        ),
        CommonText(
          title!,
          color: AppConstant.colorPrimary,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          fontFamily: AppConstant.font_barndon,
        ),
        const SizedBox(
          height: 10.0,
        ),
        CommonImageAsset(
          image: ImageConstant.ic_intro_underline,
          height: underlineHeight ?? 11.0,
          width: underlineWidth ?? MediaQuery.of(context).size.width * 0.5,
          color: color,
        ),
      ],
    );
  }
}