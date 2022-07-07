// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../utils/app_constant.dart';
import '../utils/image_constant.dart';
import '../utils/string_constant.dart';
import 'common_image_assets.dart';
import 'common_text.dart';

class ShareButton extends StatefulWidget {

  final Function()? InstaShare;
  final Function()? FbShare;
  final Function()? YouTubeShare;
  final Function()? PintrestShare;

   const ShareButton({Key? key, this.InstaShare, this.FbShare, this.YouTubeShare, this.PintrestShare}) : super(key: key);

  @override
  ShareButtonState createState() => ShareButtonState();
}

class ShareButtonState extends State<ShareButton> {
  bool isOpen = false;
  _toggleShare() {
    setState(() {
      isOpen = !isOpen;
      print("is opeeennnnnn ====>$isOpen");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.fastOutSlowIn,
          width: double.infinity,
          height: 48,
        ),
        Container(
          height: 48,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
         // margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
              color: isOpen ? AppConstant.colorPrimary.withOpacity(0.3)
                  : AppConstant.colorPrimary,
              borderRadius: BorderRadius.circular(40)
          ),
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 450),
            firstChild: Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    _toggleShare();
                  });
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonText(StringConstant.about_geburt,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      fontFamily: AppConstant.font_barndon,
                      color: AppConstant.colorWhite,
                    ),
                  ],
                ),
              ),
            ),
            secondChild: IconButton(
              icon: const Icon(Icons.close,color: AppConstant.colorWhite,),
              onPressed: (){
                setState(() {
                  _toggleShare();
                });
                setState(() {});
              },
            ),
            crossFadeState: !isOpen
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 450),
          opacity: isOpen ? 1 : 0,
          child: Container(
            height: 48,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: GestureDetector(
                        onTap: (){
                          isOpen? widget.InstaShare!():_toggleShare();
                        },
                        child: const CommonImageAsset(
                          image: ImageConstant.ic_instagram,
                          height: 40.0,
                          width: 40.0,
                        ),
                      ),
                ),

                const Spacer(),
                GestureDetector(
                  onTap: ()=>isOpen? widget.FbShare!():_toggleShare(),
                  child: const CommonImageAsset(
                    image: ImageConstant.ic_fb_outlined,
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    isOpen ? widget.YouTubeShare!():_toggleShare();
                  },
                  child: const CommonImageAsset(
                    image: ImageConstant.ic_youtube,
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 60.0),
                  child: GestureDetector(
                    onTap: () {
                      isOpen ? widget.PintrestShare!():_toggleShare();
                    },
                    child: const CommonImageAsset(
                      image: ImageConstant.ic_pintrest,
                      height: 40.0,
                      width: 40.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
