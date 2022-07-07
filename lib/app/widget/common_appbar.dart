import 'package:flutter/material.dart';
import '../utils/app_constant.dart';
import '../utils/image_constant.dart';
import 'common_image_assets.dart';
import 'common_text.dart';

class CommonAppbar extends StatefulWidget {
  final String? title;
  final bool? isBackOn, isBack;
  const CommonAppbar({Key? key, this.title, this.isBackOn, this.isBack}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CommonAppbarState createState() => _CommonAppbarState();
}

class _CommonAppbarState extends State<CommonAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 10.0, left: 12.0, right: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context, widget.isBack);
            },
            child: Container(
                height: 30.0,
                width: 30.0,
                alignment: Alignment.center,
                child: widget.isBackOn!
                    ? Stack(
                  children: const [
                    CommonImageAsset(
                      image: ImageConstant.ic_back_btn,
                      height: 18.0,
                      width: 16.0,
                    ),
                  ],
                )
                    : const SizedBox(
                  width: 40.0,
                  height: 18.0,
                )),
          ),
          Flexible(
            child: CommonText(
              widget.title!,
              fontSize: 26.0,
              fontFamily: AppConstant.font_playlist,
              fontWeight: FontWeight.w400,
              maxline: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 18.0,
            width: 16.0,
          ),
        ],
      ),
    );
  }
}

