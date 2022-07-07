import 'package:flutter/material.dart';
import '../../app/utils/app_constant.dart';
import '../../app/utils/image_constant.dart';
import '../../app/utils/string_constant.dart';
import '../../app/widget/common_button.dart';
import '../../app/widget/common_image_assets.dart';
import '../../app/widget/common_text.dart';
import '../../app/widget/common_underline.dart';
import '../login/sign_in/signin.dart';
import 'on_bording_viewmodel.dart';

class OnBordingPage extends StatefulWidget {
  const OnBordingPage({Key? key}) : super(key: key);

  @override
  OnBordingPageState createState() => OnBordingPageState();
}

class OnBordingPageState extends State<OnBordingPage> {
  OnBordingPageViewModel? model;
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;


  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    model = OnBordingPageViewModel(state: this);
    return Scaffold(
      backgroundColor: AppConstant.colorWhite,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: PageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  introPage(ImageConstant.ic_intro1, StringConstant.intro_title1, StringConstant.intro_desc1),
                  introPage(ImageConstant.ic_intro2, StringConstant.intro_title2, StringConstant.intro_desc2),
                  introPage(ImageConstant.ic_intro3, StringConstant.intro_title3, StringConstant.intro_desc3),
                ],
              ),
            ),
            _currentPage == 3 ? const SizedBox() : skipButton(),
            bottomButtonIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFB07B8B) : const Color(0xFFCCCCCC),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Widget introPage(String image, String title, String description) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonImageAsset(
            image: image,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 20.0,
          ),
          CommonTitleUnderline(
            //TODO TITLE & UNDERLINE
            title: title,
            underlineWidth: MediaQuery.of(context).size.width / 1.5,
            color: AppConstant.colorPrimary,
            underlineHeight: 10.0,
          ),
          const SizedBox(
            height: 25.0,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CommonText(
                //TODO TEXT HERE
                description,
                fontFamily: AppConstant.font_barndon,
                textAlign: TextAlign.center,
                color: AppConstant.colorTextBlack,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget skipButton() {
    return Positioned(
      right: 0.0,
      child: InkWell(
        child: Container(
          height: 28.0,
          margin: const EdgeInsets.only(left: 25.0, top:50.0,bottom:50.0,right: 25.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 5.0),
                  child: CommonText(
                    //TODO TEXT HERE
                    StringConstant.skip_btn_text,
                    color: AppConstant.colorPrimary,
                    fontSize: 12.0,
                    fontFamily: AppConstant.font_barndon,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => loginDialog(),
          );
        },
      ),
    );
  }

  Widget bottomButtonIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _currentPage != 0
                ? InkWell(
              child: const Padding(
                padding: EdgeInsets.only(left: 13.0),
                child: CommonImageAsset(
                  image: ImageConstant.ic_round_prev_btn,
                  height: 48.0,
                  width: 48.0,
                ),
              ),
              onTap: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
            )
                : const SizedBox(
              height: 48.0,
              width: 48.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            InkWell(
              child: const Padding(
                padding: EdgeInsets.only(right: 13.0),
                child: CommonImageAsset(
                  image: ImageConstant.ic_round_next_btn,
                  height: 48.0,
                  width: 48.0,
                ),
              ),
              onTap: () {
                _currentPage != _numPages - 1
                    ? _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                )
                    : showDialog(
                  context: context,
                  builder: (context) => loginDialog(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget loginDialog() {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 22.0,
      ),
      buttonPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 25.0, top: 25.0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 0.0,
      // To display the title it is optional
      content:
      SizedBox(height: 150,
          child: _allContent()),
      actions: [
        _loginButton(),
        const SizedBox(
          height: 8.0,
        ),
        _guestButton(),
      ],
    );
  }

  Widget _allContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(
        height: 40.0,
      ),
      CommonText(
        StringConstant.already_join_course,
        textAlign: TextAlign.center,
        fontSize: 18.0,
        fontFamily: AppConstant.font_barndon,
        fontWeight: FontWeight.w500,
      ),
      const SizedBox(
        height: 25.0,
      ),
      CommonText(
        StringConstant.login_dialog_desc,
        textAlign: TextAlign.center,
        fontSize: 14.0,
        fontFamily:AppConstant.font_barndon,
        fontWeight: FontWeight.w500,
      ),
    ]);
  }

  bool isLoading = false;

  Widget _loginButton() {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: CommonButton(
            padding: EdgeInsets.zero,
            buttonType: ButtonType.ElevatedButton,
            onPressed: () async {
              setState(() {
                isLoading = true;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()));

              });
            },
            color: AppConstant.colorPrimary,
            borderRadius: 25.0,
            child: CommonText(
              StringConstant.login_btn_text,
              fontSize: 15.0,
              fontFamily: AppConstant.font_barndon,
              fontWeight: FontWeight.w700,
            ),
          )
      ),
    );
  }

  Widget _guestButton() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45.0,
        margin: const EdgeInsets.only(bottom: 50.0, left: 10.0, right: 10.0),
        child: CommonButton(
          buttonType: ButtonType.ElevatedButton,
          onPressed: () async {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
            setState(() {});
          },
          color: Colors.white,
          borderRadius: 25.0,
          border: const BorderSide(color: AppConstant.colorPrimary),
          child: CommonText(
            StringConstant.skip_btn_text,
            fontFamily: AppConstant.font_barndon,
            fontWeight: FontWeight.w700,
            color: AppConstant.colorPrimary,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
