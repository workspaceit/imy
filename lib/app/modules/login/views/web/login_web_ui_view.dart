import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ilu/app/core/constants/validation/field_form_validation.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_static_text.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/login/controllers/login_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_loading_button.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LoginWebUiView extends StatelessWidget {
  final GlobalKey<FormState> loginWebFormKey;
  const LoginWebUiView({required this.loginWebFormKey, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<LoginController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: AppColors.colorWhite,
            automaticallyImplyLeading: false,
            actions: [
              /// ------------------- Language Section -------------------------
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 40, end: 40, bottom: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ToggleSwitch(
                    minWidth: 90.0,
                    initialLabelIndex: 0,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: AppColors.colorLightWhite,
                    inactiveFgColor: AppColors.colorDarkA,
                    totalSwitches: 2,
                    labels: [AppStaticText.englishLang.tr, AppStaticText.banglaLang.tr],
                    activeBgColors: const [[Colors.purple], [Colors.purple]],
                    onToggle: (index) {},
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 150),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// ------------ login screen heading --------------------------
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GradientText(AppStaticText.login.tr,
                            style: AppTextStyle.appTextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),
                            colors: const [
                              Color(0xffFFD000),
                              Color(0xffF80261),
                              Color(0xff7017FF)
                            ]),
                      ),
                      const Gap(20),
                      /// ------------ login form ------------------------------
                      Form(
                        key: loginWebFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///------------- username field --------------------
                            CustomTextFormField(
                              textEditingController: controller.usernameController,
                              hintText: AppStaticText.enterYourEmailContact,
                              prefixIcon: Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: SvgPicture.asset(AppIcons.emailField),
                              ),
                              formValidator: (value){
                                if(value.toString().isEmpty){
                                  return "Please enter email/contact number";
                                }
                                return null;
                              },
                            ),
                            const Gap(4),
                            Text(
                              AppStaticText.emailContactNumberNote.tr,
                              textAlign: TextAlign.start,
                              style: AppTextStyle.appTextStyle(
                                  textColor: AppColors.colorDarkB.withOpacity(0.6),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12
                              ),
                            ),
                            const Gap(12),
                            /// -------------- password field -----------------
                            CustomTextFormField(
                              isPassword: true,
                              textEditingController: controller.passwordController,
                              textInputAction: TextInputAction.done,
                              prefixIcon: Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: SvgPicture.asset(AppIcons.passwordField),
                              ),
                              hintText: AppStaticText.enterYourPassword.tr,
                              formValidator: (value) => passwordValidation(value),
                            )
                          ],
                        ),
                      ),
                      const Gap(20),
                      /// -------------------- forget password alert dialog ------------------
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Get.toNamed(Routes.FORGET_PASSWORD),
                          borderRadius: BorderRadius.circular(4),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.all(8.0),
                            child: Text(
                              AppStaticText.forgotPassword.tr,
                              style: GoogleFonts.inter(
                                  color: AppColors.colorDarkB,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.colorDarkB
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(20),
                      /// -------------------- login and register buttons --------------------
                      Column(
                        children: [
                          controller.isSubmit ? const CustomLoadingButton() : CustomButton(
                              onPressed: () {
                                if (loginWebFormKey.currentState!.validate()) {
                                  controller.login();
                                }
                              },
                              buttonText: AppStaticText.continueLogin.tr
                          ),
                          const Gap(20),
                          CustomOutlineButton(
                              onPressed: () => Get.toNamed(Routes.REGISTRATION),
                              buttonText: AppStaticText.register.tr,
                              textColor: AppColors.colorDarkB
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
