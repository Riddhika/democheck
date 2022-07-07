import 'package:flutter/material.dart';

import 'common_text.dart';

// ignore_for_file: constant_identifier_names

enum ButtonType {
  TextButton,
  ElevatedButton,
  OutlinedButton,
}

// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  ButtonType? buttonType;

  /// Use either `child` or `lable` property
  Widget? child;
  Icon? _icon;

  /// Use `icon` property for icon button
  final IconData? icon;

  /// Use either `child` or `lable` property
  final String? lable;
  final Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final Color? shadowColor;
  final EdgeInsets? padding;
  final FocusNode? focusNode;
  final double? elevation; //not for flat button

  /// For text size, weight.
  /// Use color property for text color
  final TextStyle? textStyle;

  /// for button border of type BorderSide(color,width,style)
  final BorderSide? border;

  /// it apply circular border type
  double? borderRadius;

  /// if want to apply custome border shape, For circular border give only borderRadius property
  OutlinedBorder? shape;

  ButtonStyle? _buttonStyle;

  CommonButton({
    Key? key,
    this.buttonType,
    this.onPressed,
    this.lable,
    this.child,
    this.icon,
    this.color,
    this.textColor,
    this.shadowColor,
    this.border,
    this.borderRadius = 0.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    this.elevation,
    this.focusNode,
    this.shape,
    this.textStyle,
  }) : super(key: key);

  Widget myButton() {
    switch (buttonType) {
      case ButtonType.TextButton:
        _buttonStyle = TextButton.styleFrom(
          backgroundColor: color,
          primary: textColor,
          elevation: elevation,
          padding: padding,
          shape: shape,
          side: border,
          shadowColor: Colors.transparent,
          textStyle: textStyle,
        );
        return textButton();

      case ButtonType.OutlinedButton:
        _buttonStyle = OutlinedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: color,
          primary: textColor,
          elevation: elevation,
          padding: padding,
          shape: shape,
          side: border,
          shadowColor: Colors.transparent,
          textStyle: textStyle,
        );
        return outlinedButton();

      case ButtonType.ElevatedButton:
        _buttonStyle = ElevatedButton.styleFrom(
          primary: color,
          onPrimary: textColor,
          elevation: elevation,
          padding: padding,
          shape: shape,
          side: border,
          shadowColor: Colors.transparent,
          textStyle: textStyle,
        );
        return elevatedButton();

      default:
        _buttonStyle = TextButton.styleFrom(
          backgroundColor: color,
          primary: textColor,
          elevation: elevation,
          padding: padding,
          shape: shape,
          side: border,
          shadowColor: shadowColor,
          textStyle: textStyle,
        );
        return textButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (shape == null && borderRadius != 0.0) {
      shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!));
    }

    child = CommonText(
      lable!,
    );

    _icon = Icon(
      icon,
    );

    return myButton();
  }

  TextButton textButton() {
    return TextButton.icon(
      icon: _icon!,
      label: child!,
      onPressed: onPressed,
      style: _buttonStyle,
      focusNode: focusNode,
    );
  }

  OutlinedButton outlinedButton() {
    return OutlinedButton.icon(
      icon: _icon!,
      label: child!,
      onPressed: onPressed,
      style: _buttonStyle,
      focusNode: focusNode,
    );
  }

  ElevatedButton elevatedButton() {
    return ElevatedButton.icon(
      icon: _icon!,
      label: child!,
      onPressed: onPressed,
      style: _buttonStyle,
      focusNode: focusNode,
    );
  }
}
