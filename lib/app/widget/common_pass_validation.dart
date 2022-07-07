import 'package:flutter/material.dart';

import '../utils/app_constant.dart';
import '../utils/image_constant.dart';
import 'common_image_assets.dart';
import 'common_text.dart';

class CommonPassValidation extends StatelessWidget {

  final String? validationTitle;
  final bool? isDone;

  const CommonPassValidation({Key? key, this.validationTitle, this.isDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 18.0,
          child: CommonImageAsset(
            image: isDone! ? ImageConstant.ic_done : ImageConstant.ic_note,
            height: 18.0,
            width: 18.0,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        CommonText(
            validationTitle!,
            fontFamily: AppConstant.font_barndon,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            color: AppConstant.colorTextBlack
        ),
      ],
    );
  }
}
