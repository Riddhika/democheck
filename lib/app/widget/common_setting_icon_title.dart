import 'package:flutter/material.dart';
import '../utils/image_constant.dart';
import 'common_image_assets.dart';
import 'common_text.dart';

class CommonSettingIcon extends StatelessWidget {
  final String? name, icon;
  final double? height, width;
  final Function()? onTap;

  const CommonSettingIcon(
      {Key? key, this.name, this.icon, this.onTap, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          left: 10.0,
          top: 10.0,
          bottom: 10.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height:24.0,
                    width: 24.0,
                    child: Stack(
                      children: [
                        Center(
                          child: CommonImageAsset(
                            image: icon,
                            height: 22.0,
                            width: 22.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  CommonText(
                    name!,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: const CommonImageAsset(
                image: ImageConstant.ic_right_back_arrow,
                height: 16.0,
                width: 16.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}