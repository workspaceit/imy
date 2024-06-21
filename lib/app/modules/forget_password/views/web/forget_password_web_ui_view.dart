import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/constants/validation/field_form_validation.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_static_text.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/forget_password/controllers/forget_password_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_loading_button.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ForgetPasswordWebUiView extends StatelessWidget {
  const ForgetPasswordWebUiView({super.key});

  @override
  Widget build(BuildContext context) {

    final forgetPasswordFormKey = GlobalKey<FormState>();

    return SafeArea(
      top: false,
      child: GetBuilder<ForgetPasswordController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: PreferredSize(
            preferredSize: Size(Get.width, 80),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  iconSize: 40,
                    onPressed: () => Get.toNamed(Routes.LOGIN),
                    icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.colorDarkA, size: 20)
                ),
              ),
            ),
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 900,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GradientText("${AppStaticText.forgotPassword.tr}?",
                          style: AppTextStyle.appTextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.w700),
                          colors: const [
                            Color(0xffFFD000),
                            Color(0xffF80261),
                            Color(0xff7017FF)
                          ]
                      ),
                    ),
                    const Gap(20),
                    Form(
                      key: forgetPasswordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// ------------------ country field
                          CustomTextFormField(
                            readOnly: true,
                            textInputAction: TextInputAction.next,
                            textEditingController: controller.countryController,
                            hintText: AppStaticText.country.tr,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.colorDarkB),
                            /// --------------------- country bottom sheet
                            onTap: () => showModalBottomSheet(
                                backgroundColor: AppColors.colorWhite,
                                context: context,
                                builder: (context) => Padding(
                                  padding: const EdgeInsetsDirectional.only(top: 12),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: 5,
                                          width: 75,
                                          decoration: BoxDecoration(
                                              color: AppColors.colorDarkA.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(12)),
                                        ),
                                      ),
                                      const Gap(16),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppStaticText.selectCountry.tr,
                                              textAlign: TextAlign.left,
                                              style: AppTextStyle.appTextStyle(
                                                  textColor: AppColors.colorDarkA,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Gap(16),
                                      Flexible(
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                                          physics: const BouncingScrollPhysics(),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: List.generate(countries.length, (index) => InkWell(
                                              borderRadius: BorderRadius.circular(12),
                                              onTap: () => controller.chooseCountry(index),
                                              child: Container(
                                                padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                                                margin: const EdgeInsetsDirectional.only(bottom: 8),
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(
                                                        color: AppColors.colorGrayB, width: 1)),
                                                child: Text(
                                                  countries[index].name,
                                                  style: AppTextStyle.appTextStyle(
                                                      textColor: AppColors.colorDarkB,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),
                            formValidator: (value){
                              if(value.isEmpty){
                                return "Please select your country";
                              }else{
                                return null;
                              }
                            },
                          ),
                          controller.countryController.text == "" ? const SizedBox() : Column(
                            children: [
                              const Gap(12),
                              controller.countryController.text == "Bangladesh" ? CustomTextFormField(
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.phone,
                                textEditingController:
                                controller.contactNumberController,
                                hintText: AppStaticText.enterYourContactNumber,
                                prefixIcon: Padding(
                                  padding: const EdgeInsetsDirectional.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child:
                                  SvgPicture.asset(AppIcons.verifyContactField),
                                ),
                                formValidator: (value) => contactNumberValidation(value),
                              ) : CustomTextFormField(
                                textInputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                textEditingController: controller.emailOrContactController,
                                hintText: AppStaticText.enterYourEmail.tr,
                                prefixIcon: Padding(
                                  padding: const EdgeInsetsDirectional.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: SvgPicture.asset(AppIcons.emailField),
                                ),
                                formValidator: (value){
                                  if(value.toString().isEmpty){
                                    return "Please enter email";
                                  }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controller.emailOrContactController.text)){
                                    return "Please enter valid email";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(24),
                    controller.isSubmit ? const CustomLoadingButton() : CustomButton(
                      onPressed: () {
                        if(forgetPasswordFormKey.currentState!.validate()){
                          controller.countryController.text == "Bangladesh" ? controller.forgetPasswordPhoneVerify() : controller.forgetPasswordEmailVerify();
                        }
                      },
                      buttonText: AppStaticText.proceed.tr
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
