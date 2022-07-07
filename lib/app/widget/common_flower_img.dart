import 'package:flutter/material.dart';
import '../utils/image_constant.dart';
import 'common_image_assets.dart';

class CommonFlower extends StatelessWidget {
  const CommonFlower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: const CommonImageAsset(
          image: ImageConstant.ic_flower_img,
          height: 200.0,
          width: 200.0,
        ));
  }
}