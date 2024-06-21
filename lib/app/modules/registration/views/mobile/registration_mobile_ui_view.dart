import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_static_text.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/registration/controllers/registration_controller.dart';
import 'package:ilu/app/modules/registration/views/inner_widget/registration_form.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RegistrationMobileUiView extends StatefulWidget {

  const RegistrationMobileUiView({super.key});

  @override
  State<RegistrationMobileUiView> createState() => _RegistrationMobileUiViewState();
}

class _RegistrationMobileUiViewState extends State<RegistrationMobileUiView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<RegistrationController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.colorWhite,
            title: GradientText(
              AppStaticText.registration.tr,
              style: AppTextStyle.appTextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              colors: const [
                Color(0xffFFD000),
                Color(0xffF80261),
                Color(0xff7017FF)
              ]
            ),
          ),
          body: const SingleChildScrollView(
            padding: EdgeInsetsDirectional.only(start: 24, top: 20, end: 24, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ---------------------------- text field form
                RegistrationForm(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
