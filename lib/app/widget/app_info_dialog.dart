import 'package:flutter/material.dart';
import 'package:flutter_mvvm_structure/app/utils/app_constant.dart';
import 'package:package_info/package_info.dart';
import '../utils/string_constant.dart';
import 'common_button.dart';
import 'common_text.dart';

class AppInfoDialog extends StatefulWidget {
  const AppInfoDialog({Key? key}) : super(key: key);

  @override
  AppInfoDialogState createState() => AppInfoDialogState();
}

class AppInfoDialogState extends State<AppInfoDialog> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(left: 25.0, bottom: 10, right: 25.0),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 0.0,
      // To display the title it is optional
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: CommonText(
          StringConstant.app_info,
          fontSize: 16.0,
          color: AppConstant.colorTextBlack,
          fontFamily: AppConstant.font_barndon,
          fontWeight: FontWeight.w700,
          maxline: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
      content: Container(
        height: 140,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 25.0,
            ),
            commonRow("App Name:", _packageInfo.appName),
            const SizedBox(
              height: 15.0,
            ),
            commonRow("App Version:", _packageInfo.version),
            const SizedBox(
              height: 15.0,
            ),
            commonRow("App Build-Nummer:", _packageInfo.buildNumber),
          ],
        ),
      ),
      actions: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              width: double.infinity,
              height: 42.0,
              child: CommonButton(
                buttonType: ButtonType.ElevatedButton,
                borderRadius: 25.0,
                padding: EdgeInsets.zero,
                elevation: 0.0,
                color: AppConstant.colorPrimary,
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: CommonText(StringConstant.ok_text,
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        )
      ],
    );
  }

  commonRow(title, value) {
    return SizedBox(
      width: double.infinity,
      child: Row(children: [
        Expanded(
          child: CommonText(
            title,
            fontSize: 12.0,
            textAlign: TextAlign.left,
            fontFamily: AppConstant.font_barndon,
            fontWeight: FontWeight.w700,
          ),
        ),
        Expanded(
          child: CommonText(
            value,
            fontSize: 12.0,
            maxline: 2,
            textAlign: TextAlign.left,
            fontFamily: AppConstant.font_barndon,
            fontWeight: FontWeight.w400,
          ),
        ),
      ]),
    );
  }
}