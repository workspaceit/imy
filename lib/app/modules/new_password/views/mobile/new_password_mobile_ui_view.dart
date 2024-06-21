import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_static_text.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/new_password/controllers/new_password_controller.dart';
import 'package:ilu/app/widgets/bottom_nav/auth_bottom_nav.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_loading_button.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class NewPasswordMobileUiView extends StatelessWidget {
  const NewPasswordMobileUiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<NewPasswordController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 24, vertical: 20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientText(AppStaticText.newPassword.tr,
                      style: AppTextStyle.appTextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.w700),
                      colors: const [
                        Color(0xffFFD000),
                        Color(0xffF80261),
                        Color(0xff7017FF)
                      ]),
                  const Gap(20),
                  Form(
                      key: controller.newPasswordKey,
                      child: Column(children: [
                        CustomTextFormField(
                            isPassword: true,
                            textEditingController:
                            controller.newPasswordController,
                            textInputAction: TextInputAction.next,
                            prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: SvgPicture.asset(AppIcons.passwordField),
                            ),
                            hintText: AppStaticText.enterANewPassword.tr,
                            onChanged: (value) => controller.checkPasswordLength(value),
                            formValidator: (value) {
                              if(value.isEmpty){
                                return "Please, enter your new password";
                              }
                              return null;
                            }),
                        const Gap(12),
                        CustomTextFormField(
                            isPassword: true,
                            textEditingController:
                            controller.reEnterPasswordController,
                            textInputAction: TextInputAction.done,
                            prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: SvgPicture.asset(AppIcons.passwordField),
                            ),
                            hintText: AppStaticText.reEnterTheNewPassword.tr,
                            formValidator: (value) {
                              if(value.isEmpty){
                                return "Please, re-enter your password";
                              }else if(controller.newPasswordController.text != controller.reEnterPasswordController.text){
                                return "Passwords don't match";
                              }
                              return null;
                            }),
                      ])),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AppIcons.circleCheckbox,
                          height: 16, width: 16),
                      const Gap(8),
                      Text(
                        AppStaticText.mustBeAtLeastFourCharacters.tr,
                        style: AppTextStyle.appTextStyle(
                            textColor: controller.passwordLength > 4 ? CupertinoColors.systemGreen : AppColors.colorDarkB,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: AuthBottomNav(
            bottomNavChild: controller.isSubmit ? const CustomLoadingButton() : CustomButton(
                onPressed: () {
                  if (controller.newPasswordKey.currentState!.validate()) {
                    controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.userTypeKey) != "Bangladesh" ?
                    controller.resetPasswordForCaller() : controller.resetPasswordForReceiver();
                  }
                },
                buttonText: AppStaticText.reset.tr
            ),
          ),
        ),
      ),
    );
  }
}
