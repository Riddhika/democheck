import 'package:flutter/material.dart';
import '../utils/app_constant.dart';
import '../utils/full_screen_loder.dart';
import '../utils/string_constant.dart';
import 'common_button.dart';
import 'common_text.dart';

class ExperienceReportDialog extends StatefulWidget {
  const ExperienceReportDialog({Key? key}) : super(key: key);

  @override
  ExperienceReportDialogState createState() => ExperienceReportDialogState();
}

class ExperienceReportDialogState extends State<ExperienceReportDialog> {
  final _formPageKey = GlobalKey<FormState>();
  String? experience;
  bool isExperienceFill = false, isSubmitEnable = false, isLoading = false;
  TextEditingController experienceController = TextEditingController();

  checkExperienceBtnEnabled() {
    if (experience!.isNotEmpty) {
      isSubmitEnable = true;
    } else {
      isSubmitEnable = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 12, left: 20, bottom: 20, right: 20),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 0.0,
      actions: [
        Form(
          key: _formPageKey,
          child: Container(
            width: MediaQuery.of(context).size.width / 1.00,
            height: MediaQuery.of(context).size.height * 0.35,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CommonText(
                  StringConstant.experience_repo_text,
                  fontSize: 18.0,
                  textAlign: TextAlign.center,
                  fontFamily: AppConstant.font_barndon,
                  fontWeight: FontWeight.w700,
                  color: AppConstant.colorTextBlack,
                ),
                const SizedBox(
                  height: 15,
                ),
                _experienceField(),
                const SizedBox(
                  height: 20,
                ),
                _submitButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _experienceField() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.170,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: isExperienceFill ? AppConstant.colorTextBlack : AppConstant
              .colorGrey,
          width: 1,
        ),
      ),
      child: TextFormField(
        minLines: null,
        maxLines: null,
        cursorColor: AppConstant.colorPrimary,
        onChanged: (val) {
          setState(() {
            experience = val;
            checkExperienceBtnEnabled();
            setState(() {});
          });
        },
        enabled: isLoading ? false : true,
        onTap: () {
          setState(() {
            isExperienceFill = true;
          });
        },
        textInputAction: TextInputAction.newline,
        controller: experienceController,
        keyboardType: TextInputType.multiline,
        validator: (val) {
          if (val!.isEmpty) {
            return 'Bitte ${StringConstant.enter_experience_text}';
          }
          return null;
        },
        decoration: const InputDecoration(
          // floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            isDense: true,
            contentPadding: EdgeInsets.only(
                left: 15, top: 10, bottom: 10, right: 10),
            border: InputBorder.none,
            hintText: StringConstant.enter_experience_text,
            hintMaxLines: 2),
      ),
    );
  }

  Widget _submitButton() {
    return isLoading
        ? const FullScreenLoader()
        : Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: CommonButton(
          buttonType: ButtonType.ElevatedButton,
          onPressed: isSubmitEnable
              ? () {
            openKeyBoard(context: context);
            if (_formPageKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              try{
                print("EXPERIENCE REPORT DAILOG");
              } catch (e) {
                print("Exception :- $e");
                isLoading = false;
              }
            } else {
              setState(() {
                isLoading = false;
              });
            }
          }
              : () {},
          elevation: 0.0,
          color: isSubmitEnable
              ? AppConstant.colorPrimary
              : AppConstant.colorPrimary.withOpacity(0.3),
          borderRadius: 25.0,
          child: CommonText(StringConstant.send_text,
            fontSize: 16.0,
            fontFamily: AppConstant.font_barndon,
            fontWeight: FontWeight.w700,
          ),
        ));
  }
}
