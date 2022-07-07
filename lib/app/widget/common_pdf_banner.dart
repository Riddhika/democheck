// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../utils/app_constant.dart';
import 'common_image_assets.dart';
import 'common_text.dart';


class CommonPdfBanner extends StatefulWidget {
 final String? MainImage;
 final String? title;
 final String? descprtion;
 final String? BackImage;
 final Function()? onTap;

  const CommonPdfBanner({Key? key, this.MainImage, this.title, this.descprtion, this.BackImage, this.onTap}) : super(key: key);

  @override
  CommonPdfBannerState createState() => CommonPdfBannerState();
}

class CommonPdfBannerState extends State<CommonPdfBanner> {
  @override
  Widget build(BuildContext context) {
   return Container(
      width: double.infinity,
      height: 146.0,
      margin: const EdgeInsets.only(left: 22.0, right: 22.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), boxShadow: const [
        BoxShadow(
          color: AppConstant.colorBoxShadow,
          spreadRadius: 4,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                height: 200.0,
                width: 120.0,
                child: CommonImageAsset(
                  image:widget.MainImage,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          CommonText(
                            widget.title!,
                            fontFamily: AppConstant.font_lato,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            color: AppConstant.colorTextBlack,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: CommonText(
                             widget.descprtion!,
                              fontFamily: AppConstant.font_barndon,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: widget.onTap,
            child: Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.all(15.0),
              child: CommonImageAsset(
                image: widget.BackImage,
                height: 30.0,
                width: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
