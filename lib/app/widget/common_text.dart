// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxline;
  final TextDecoration? decoration;
  final String? fontFamily;
  final TextOverflow? overflow;
  double? height;

  CommonText(
      this.text ,
      {Key? key,
        this.fontSize,
        this.fontWeight,
        this.color,
        this.textAlign,
        this.height,
        this.maxline, this.decoration, this.fontFamily, this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      overflow: overflow,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          height: height,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration
      ),
      textAlign: textAlign,
      maxLines: maxline,
    );
  }
}