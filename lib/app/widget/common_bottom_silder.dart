import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../utils/app_constant.dart';
import '../utils/image_constant.dart';
import '../utils/string_constant.dart';
import 'common_button.dart';
import 'common_image_assets.dart';
import 'common_text.dart';

class BottomSlider extends StatefulWidget {
  const BottomSlider({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomSliderState createState() => _BottomSliderState();
}

class _BottomSliderState extends State<BottomSlider> {
 bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.cancel_rounded,
                  color: AppConstant.colorPrimary,
                  size: 30,),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CommonImageAsset(
                  image: ImageConstant.ic_flower_img,
                  height: 40.0,
                  width: 40.0,
                ),
                CommonText(StringConstant.report_problem,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.font_playlist,
                  color: AppConstant.colorTextBlack,
                ),
                const CommonImageAsset(
                  image: ImageConstant.ic_flower_img,
                  height: 40.0,
                  width: 40.0,
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0),
                child: CommonText(
                  StringConstant.are_you_upset_with_app,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.font_lato,
                  color: AppConstant.colorTextBlack,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            CommonText(StringConstant.your_feed_helps_us,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.font_lato,
              color: AppConstant.colorTextBlack,
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: CommonButton(
                borderRadius: 25.0,
                elevation: 0.0,
                buttonType: ButtonType.ElevatedButton,
                onPressed: () {
                },
                color: AppConstant.colorPrimary,
                child: CommonText(
                  StringConstant.report_pro_btn,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  fontFamily: AppConstant.font_barndon,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            const Divider(color: AppConstant.colorDivider),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .start,
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: [
                        CommonText(
                          StringConstant
                              .shake_ph_to_report_prob,
                          fontFamily: AppConstant.font_lora,
                          fontWeight: FontWeight.w900,
                          fontSize: 14.0,
                          textAlign: TextAlign.start,),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              right: 30.0),
                          child:
                          CommonText(
                            StringConstant.learn_more,
                            fontFamily: AppConstant.font_lora,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.0,
                            textAlign: TextAlign.start,),
                        )
                      ],
                    ),
                  ),
                  FlutterSwitch(
                    width: 44.0,
                    height: 24.0,
                    toggleSize: 15.0,
                    borderRadius: 30.0,
                    padding: 2.0,
                    value: isSwitched,
                    activeToggleColor: AppConstant
                        .colorPrimary,
                    inactiveToggleColor: Colors.white,
                    inactiveToggleBorder: Border.all(
                      color: AppConstant.colorPrimary,
                      width: 2.0,
                    ),
                    toggleColor: AppConstant.colorPrimary,
                    switchBorder: Border.all(
                      color: AppConstant.colorTextBlack
                          .withOpacity(0.5),
                      width: 2.0,
                    ),
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    onToggle: (val) async {
                      // print("SWITCH IS CALLEDs$val");
                      //
                      isSwitched = val;
                      print("SWITCH IS CALLEDs$isSwitched");
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
