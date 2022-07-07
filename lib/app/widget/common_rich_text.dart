import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CommonRichText extends StatelessWidget {
  final String? firstText;
  final TextStyle? firstTextStyle;
  final String? secondText;
  final TextStyle? secondTextStyle;
  final String? second1Text;
  final TextStyle? second1TextStyle;
  final String? thirdText;
  final TextStyle? thirdTextStyle;
  final Function? secondTextTap,second1TextTap;

  const CommonRichText(
      {Key? key,
        this.firstText,
        this.firstTextStyle,
        this.secondText,
        this.secondTextStyle,
        this.thirdText,
        this.thirdTextStyle,
        this.secondTextTap, this.second1Text, this.second1TextStyle, this.second1TextTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: firstTextStyle,
        children: [
          TextSpan(
              recognizer: TapGestureRecognizer()..onTap = secondTextTap as GestureTapCallback?,
              text: secondText,
              style: secondTextStyle),

          TextSpan(
              recognizer: TapGestureRecognizer()..onTap = second1TextTap as GestureTapCallback?,
              text: second1Text,
              style: second1TextStyle),

          thirdText != null
              ? TextSpan(text: thirdText, style: thirdTextStyle)
              : const TextSpan(),
        ],
      ),
    );
  }
}