import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonImageAsset extends StatelessWidget {
  final double? height, width;
  final String? image;
  final BoxFit? fit;
  final Color? color;

  const CommonImageAsset({Key? key, this.image, this.fit, this.height, this.width, this.color,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image!.split('.').last == 'png'
        ? Image.asset(
      image!,
      fit: fit,
      height: height,
      width: width,
      color: color,
    )
        :  SvgPicture.asset(
      image!,
      // fit: fit,
      height: height,
      width: width,
      color: color,
    );
  }
}