import 'package:flutter/material.dart';
import '../utils/app_constant.dart';
import '../utils/string_constant.dart';
import 'common_appbar.dart';
import 'common_text.dart';

class FossPage extends StatefulWidget {
  const FossPage({Key? key}) : super(key: key);

  @override
  FossPageState createState() => FossPageState();
}

class FossPageState extends State<FossPage> {
  @override
  Widget build(BuildContext context) {
    print("runtimeType -> $runtimeType");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: CommonAppbar(
                title:StringConstant.foss_text,
                isBackOn: true,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 5),
              margin: const EdgeInsets.only(top: 90),
              decoration:
              const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
              child: ListView(
                padding: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 20),
                children: [
                  CommonText(StringConstant.general, color: AppConstant.colorTextBlack, fontSize: 12,fontWeight: FontWeight.w500,),
                  fossWidget("flutter_facebook_auth, 3.0.0", "BSD-2-Clause License", "Copyright 2018 Iiro Krankka"),
                  fossWidget("shared_preferences, 2.0.6", "BSD-3-Clause License", "Copyright 2013 The Flutter Authors. All rights reserved."),
                  fossWidget("pin_code_fields, 7.2.0", "MIT License", "Copyright (c) 2019 A. K. M. Saiful Islam"),
                  fossWidget("flutter_switch, 0.3.2", "BSD-3-Clause License", "Copyright (c) 2020, Nichole John Romero All rights reserved."),
                  fossWidget("google_sign_in, 5.0.4", "BSD-3-Clause License", "Copyright 2013 The Flutter Authors. All rights reserved."),
                  fossWidget("http, 0.13.4", "BSD-3-Clause License", "Copyright 2014, the Dart project authors. "),
                  fossWidget("provider, 6.0.1", "MIT License", "Copyright (c) 2019 Remi Rousselet"),
                  fossWidget("sign_in_with_apple, 3.0.0", "MIT License", "Copyright 2019 sign_in_with_apple authors"),
                  fossWidget("firebase_core, 1.3.0", "BSD-3-Clause License", "Copyright 2017, the Chromium project authors. All rights reserved."),
                  fossWidget("firebase_messaging, 10.0.2", "BSD-3-Clause License", "Copyright 2017, the Chromium project authors. All rights reserved."),
                  fossWidget("flutter_svg, 1.0.0", "MIT License", "Copyright (c) 2018 Dan Field"),
                  fossWidget("path_provider, 1.7.1", "BSD-3-Clause License", "Copyright 2013 The Flutter Authors. All rights reserved."),
                  fossWidget("overlay_support, 1.2.1", "Apache-2.0 License", "Copyright 2013 The Flutter Authors. All rights reserved."),
                  fossWidget("package_info, 2.0.2", "BSD-3-Clause License", "Copyright 2013 The Flutter Authors. All rights reserved."),
                  fossWidget("cupertino_icons, 1.0.4", "MIT License", "Copyright (c) 2016 Vladimir Kharlampidi"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fossWidget(title, subtitle, description) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(title, color: AppConstant.colorPrimary, fontSize: 15,fontWeight: FontWeight.w500,),
            const SizedBox(height: 10),
            CommonText(subtitle, color: AppConstant.colorTextBlack, fontSize: 12,fontWeight: FontWeight.w500,),
            CommonText(description, color: AppConstant.colorGrey, fontSize: 12),
            Container(margin: const EdgeInsets.only(top: 15), color: Colors.grey.withOpacity(0.3), height: 1)
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
