import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_constant.dart';

// ignore: must_be_immutable
class CommonTextField extends StatefulWidget {
  String? text, hintText;
  TextInputType? inputType;
  bool? obsecureText;
  TextEditingController? controller;
  int? maxline;
  double? height;
  FocusNode? focusNode;
  int? inputLength;
  Function(String)? onFieldSubmitted;
  String? Function(String?)? validator;
  TextInputAction? textInputAction;
  Image? iconSuffix;
  Function()? onSuffixTap;
  Function(String)? onChanged;
  Function()? onTap;
  bool? isEnabled;
  bool? isFill = false;
  Alignment? alignment;

  CommonTextField({
    Key? key,
    this.text,
    this.controller,
    this.inputType,
    this.obsecureText = false,
    this.maxline,
    this.height,
    this.inputLength = 100,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.iconSuffix,
    this.hintText,
    this.onSuffixTap,
     this.onChanged,
    this.onTap,
    this.isEnabled,
    this.isFill = false,
    this.textInputAction,
    this.alignment,
  }) : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      alignment: widget.alignment,
      height: widget.height ?? MediaQuery.of(context).size.height * 0.090,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: widget.isFill! ? AppConstant.colorTextBlack :AppConstant.colorGrey,
          width: 1,
        ),
      ),
      child: TextFormField(
        cursorColor: AppConstant.colorPrimary,
        onChanged: widget.onChanged,
        enabled: widget.isEnabled,
        onTap: widget.onTap,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(
              r'(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])')),
          LengthLimitingTextInputFormatter(widget.inputLength), // for mobile
        ],
        textInputAction: widget.textInputAction,
        controller: widget.controller,
        keyboardType: widget.inputType,
        obscureText: widget.obsecureText!,
        obscuringCharacter: '*',
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        maxLines: widget.maxline ?? 1,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          alignLabelWithHint: false,
          isDense: true,
          suffixIcon: IconButton(icon: widget.iconSuffix ?? const SizedBox(), onPressed: widget.onSuffixTap),
          contentPadding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
          labelStyle: const TextStyle(color: AppConstant.colorGrey, fontSize: 16.0, fontWeight: FontWeight.w400,  fontFamily: AppConstant.font_barndon,),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppConstant.colorGrey, fontSize: 16.0, fontWeight: FontWeight.w400,  fontFamily: AppConstant.font_barndon,),
          labelText: widget.text,
        ),
      ),
    );
  }
}
