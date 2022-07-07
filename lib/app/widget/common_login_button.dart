import 'package:flutter/material.dart';
import '../utils/app_constant.dart';
import 'common_button.dart';
import 'common_image_assets.dart';
import 'common_text.dart';

class CommonLoginButton extends StatelessWidget {
  final Color? color;
  final String? icon;
  final String? text;
  final Color? textColor;
  final BorderSide? border;
  final Function()? onTap;
  final String? fontFamily;
  final int? maxLineText;

  const CommonLoginButton(
      {Key? key, this.color, this.icon, this.text, this.onTap, this.border, this.textColor, this.fontFamily,this.maxLineText=1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 48.0,
        margin: const EdgeInsets.only(left: 20.0,right: 20.0),
        child: CommonButton(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          buttonType: ButtonType.ElevatedButton,
          elevation: 0.0,
          onPressed: onTap,
          borderRadius: 25.0,
          border: border,
          color: color,
          child: SizedBox(
            height: 48.0,
            child: Row(
              children: [
                CommonImageAsset(
                  image: icon,
                  height: 18.0,
                  width: 18.0,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: CommonText(
                    text!,
                    fontSize: 14.0,
                    maxline: maxLineText!,
                    color: textColor!,
                    fontFamily: AppConstant.font_barndon,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}