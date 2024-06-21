import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_static_text.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/registration/controllers/registration_controller.dart';
import 'package:ilu/app/modules/registration/views/inner_widget/registration_form_web.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RegistrationWebUiView extends StatelessWidget {

  const RegistrationWebUiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<RegistrationController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          body: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.only(start: 24, top: 40, end: 24, bottom: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 400,
                  child: Column(
                    children: [
                      /// ----------------- screen heading text ------------------
                      GradientText(
                          AppStaticText.registration.tr,
                          style: AppTextStyle.appTextStyle(fontSize:24, fontWeight: FontWeight.w700),
                          colors: const [
                            Color(0xffFFD000),
                            Color(0xffF80261),
                            Color(0xff7017FF)
                          ]
                      ),
                      const Gap(20),

                      /// ---------------- text field form ---------------------
                      const RegistrationFormWeb()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
