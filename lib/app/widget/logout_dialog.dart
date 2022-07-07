import 'package:flutter/material.dart';
import '../utils/app_constant.dart';
import '../utils/string_constant.dart';
import 'common_button.dart';
import 'common_text.dart';

class LogOutDialog extends StatefulWidget {
  final String? textone;
  final Function()? onPressed;
  const LogOutDialog({Key? key, this.textone, this.onPressed}) : super(key: key);

  @override
  LogOutDialogState createState() => LogOutDialogState();
}

class LogOutDialogState extends State<LogOutDialog> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // SignInProvider authProvider = Provider.of<SignInProvider>(context);
    return AlertDialog(
      contentPadding: const EdgeInsets.only(
        top: 48,
        bottom: 36,
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 0.0,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CommonText(widget.textone,
          //StringConstant.logout_title_text,
          fontSize: 18.0,
          maxline: 2,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w700,
          color: AppConstant.colorTextBlack,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: CommonButton(
                  buttonType: ButtonType.ElevatedButton,
                  borderRadius: 25.0,
                  padding: EdgeInsets.zero,
                  elevation: 0.0,
                  color: AppConstant.colorPrimary,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: CommonText(StringConstant.no_text,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: CommonButton(
                  buttonType: ButtonType.ElevatedButton,
                  color: Colors.white,
                  border: const BorderSide(color: AppConstant.colorPrimary),
                  borderRadius: 25.0,
                  elevation: 0.0,
                  padding: EdgeInsets.zero,
                  onPressed:widget.onPressed,
                  child: CommonText(StringConstant.yes_text,
                    color: AppConstant.colorPrimary,
                    fontSize: 14.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ],
    );
  }
}