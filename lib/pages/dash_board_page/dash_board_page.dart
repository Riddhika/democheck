import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../app/utils/app_constant.dart';
import '../../app/utils/image_constant.dart';
import '../../app/utils/string_constant.dart';
import '../../app/widget/common_button.dart';
import '../../app/widget/common_image_assets.dart';
import '../../app/widget/common_text.dart';
import '../../app/widget/shake.dart';
import '../login/register/register_model.dart';
import 'dash_board_page_viewmodel.dart';
import 'tabbar_pages/tabbar_home/home_page.dart';

class DashboardPage extends StatefulWidget {
  final ResponseData? responseData;
  const DashboardPage({Key? key, this.responseData}) : super(key: key);

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TabController? tabController;
  List<Widget>? buildTabbarPage;
  DashboardPageViewModel? model;
  bool isHome = true,
      isSetting = false,isSwitchOn=true,isSwitchOff=false;
  bool isShowing = false;
  FlutterShakePlugin? _shakePlugin;
  int _counter = 0;
  bool isSwitched = false;
  bool? sound;
  bool? alert;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    buildTabbarPage = [
      const HomePage(),
      const HomePage(),
    ];
    super.initState();
    isShowing = false;
    _shakePlugin = FlutterShakePlugin(
        shouldVibrate: isShowing,
        shakeThresholdGravity: 5,
        onPhoneShaken: () {
          //Todo stuff on phone shake
          print('phone shakes');
          _counter++;
          print('phone shakes Counter $_counter');
          print('phone shakes Counter ${_counter % 5}');
          if (_counter % 5 == 0) {
            if (isShowing == false) {
              isShowing = true;
              _shakePlugin!.stopListening();
              showModalBottomSheet(
                // context and builder are
                // required properties in this widget
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    // we set up a container inside which
                    // we create center column and display text
                    return Container(
                      height: MediaQuery.of(context).size.height * .49,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: AppConstant.colorBoxShadow,
                              spreadRadius: 4,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      child:switchButton(),
                    );
                  }).whenComplete(() {
                _counter = 0;
                isShowing = false;
                _shakePlugin!.startListening();
              });
            }
          }
        }
    )
      ..startListening();
    super.initState();
  }
  @override
  void dispose() {
    tabController!.dispose();
    _shakePlugin!.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    opHeaderColor(color: AppConstant.colorWhite);
    model = DashboardPageViewModel(state: this);
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
            children: [
              TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: buildTabbarPage!,
              ),
            ]
        ),
      ),
      bottomNavigationBar: menu(),
    );
  }

  Widget menu() {
    return Container(
      color: const Color(0xFF3F5AA6),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.white,
        child: BottomAppBar(
          elevation: 0.0,
          notchMargin: 0.8,
          shape: const CircularNotchedRectangle(),
          child: TabBar(
            onTap: (int index) {
              print("index: $index");
              if (index == 2) {}
              setState(() {
                _setTabbar(index);
              });
            },
            labelStyle: const TextStyle(
              fontSize: 10,
            ),
            physics: const ClampingScrollPhysics(),
            labelColor: AppConstant.colorPrimary,
            unselectedLabelColor: AppConstant.colorGrey,
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(0.0),
            labelPadding: EdgeInsets.zero,
            indicatorColor: AppConstant.colorPrimary,
            controller: tabController,
            indicator: const UnderlineTabIndicator(
              insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 72.0),
              borderSide: BorderSide(color: AppConstant.colorPrimary, width: 2),
            ),
            tabs: [
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 7.0),
                icon: CommonImageAsset(
                  image: ImageConstant.ic_tab_home,
                  width: 22.0,
                  height: 22.0,
                  color: isHome ? AppConstant.colorPrimary : AppConstant
                      .colorTextBlack,
                ),
                child: CommonText(isHome
                    ? StringConstant.tab_home.toUpperCase()
                    : StringConstant.tab_home,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.font_barndon,
                  fontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  color: isHome ? AppConstant.colorPrimary : AppConstant.colorTextBlack,
                ),
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 7.0),
                icon: CommonImageAsset(
                  image: ImageConstant.ic_tab_setting,
                  width: 22.0,
                  height: 22.0,
                  color: isSetting ? AppConstant.colorPrimary : AppConstant.colorTextBlack,
                ),
                child: CommonText(isSetting
                    ? StringConstant.tab_setting.toUpperCase()
                    : StringConstant.tab_setting,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.font_barndon,
                  fontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  color: isSetting ? AppConstant.colorPrimary : AppConstant
                      .colorTextBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setTabbar(int currentIndex) {
    isHome = false;
    isSetting = false;
    switch (currentIndex) {
      case 0:
        setState(() {
          isHome = true;
        });
        break;
      case 1:
        setState(() {
          isSetting = true;
        });
        break;
    }
  }
  switchButton(){
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
