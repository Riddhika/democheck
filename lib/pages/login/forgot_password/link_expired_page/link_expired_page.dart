import 'package:flutter/material.dart';
import '../../../../app/dynamic_link_service/dynamic_link_service.dart';
import '../../../../app/utils/app_constant.dart';
import '../../../../app/utils/string_constant.dart';
import '../../../../app/widget/common_button.dart';
import '../../../../app/widget/common_flower_img.dart';
import '../../../../app/widget/common_image_assets.dart';
import '../../../../app/widget/common_text.dart';

class LinkExpiredPage extends StatefulWidget {
  const LinkExpiredPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LinkExpiredPageState createState() => _LinkExpiredPageState();
}

class _LinkExpiredPageState extends State<LinkExpiredPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    // initDynamicLinks(context: context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("state :- $state");
    if (state == AppLifecycleState.resumed) {
      initDynamicLinks(context: context);
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("runtimeType -> $runtimeType");
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        // Platform.isIOS ? exit(0) : SystemNavigator.pop();
                        getIntroPage(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 20.0),
                        child: CommonImageAsset(
                      //image: ImageConstant.ic_back,
                      height: 18.0,
                      width: 16.0,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: CommonText(
                          "",
                          fontSize: 26.0,
                          fontFamily: AppConstant.font_barndon,
                          fontWeight: FontWeight.w400,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                      width: 40.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0, bottom: 10.0),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          linkExpiredText(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          _loginButton(),
                          const CommonFlower()
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }

  Widget linkExpiredText() {
    return Align(
      alignment: Alignment.topLeft,
      child: CommonText(StringConstant.link_expire,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: AppConstant.font_playlist,
        color: AppConstant.colorTextBlack,
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
        width: double.infinity,
        child: CommonButton(
          buttonType: ButtonType.ElevatedButton,
          onPressed: () {
            getIntroPage(context);
          },
          elevation: 0.0,
          color: AppConstant.colorPrimary,
          borderRadius: 25.0,
          child: CommonText(
            StringConstant.save_on_com,
            fontSize: 16.0,
            fontFamily: AppConstant.font_playlist,
            fontWeight: FontWeight.w700,
          ),
        ));
  }
}
