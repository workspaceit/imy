import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/modules/registration_otp/controllers/registration_otp_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_loading_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RegistrationOtpWebView extends StatelessWidget {

  const RegistrationOtpWebView({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: GetBuilder<RegistrationOtpController>(
          builder: (controller) => Scaffold(
            backgroundColor: AppColors.colorWhite,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.colorWhite,
              leading: IconButton(
                  onPressed: () => Get.back(),
                  alignment: Alignment.center,
                  icon: SvgPicture.asset(AppIcons.arrowBack),
                  iconSize: 24),
              title: Text(
                "Registration",
                textAlign: TextAlign.center,
                style: AppTextStyle.appTextStyle(
                    textColor: AppColors.colorDarkA,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
                child: SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientText("OTP Verification",
                          style: AppTextStyle.appTextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w700),
                          colors: const [
                            Color(0xffFFD000),
                            Color(0xffF80261),
                            Color(0xff7017FF)
                          ]),
                      const Gap(20),
                      controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.userTypeKey) == "Bangladesh" ? RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "We already have sent the OTP code via message to ",
                                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontSize: 14, fontWeight: FontWeight.w400)
                              ),
                              TextSpan(
                                  text: controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.phoneNumberKey),
                                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 14, fontWeight: FontWeight.w500)
                              )
                            ]
                        ),
                      ) : RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "We already have sent the OTP code via message to ",
                                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontSize: 14, fontWeight: FontWeight.w400)
                              ),
                              TextSpan(
                                  text: controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.emailKey),
                                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 14, fontWeight: FontWeight.w500)
                              )
                            ]
                        ),
                      ),
                      const Gap(20),
                      PinCodeTextField(
                        appContext: context,
                        length: 4,
                        textStyle: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontWeight: FontWeight.w600, fontSize: 14),
                        obscureText: true,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            fieldWidth: 80,
                            fieldHeight: 40,
                            shape: PinCodeFieldShape.box,
                            borderWidth: 1,
                            borderRadius: BorderRadius.circular(99),
                            inactiveColor: AppColors.colorGrayA,
                            inactiveFillColor: AppColors.colorWhite,
                            activeFillColor: AppColors.colorWhite,
                            activeColor: AppColors.colorDarkA,
                            selectedFillColor: AppColors.colorWhite,
                            selectedColor: AppColors.colorDarkA
                        ),
                        cursorColor: AppColors.colorDarkA,
                        animationDuration: const Duration(milliseconds: 0),
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        onChanged: (value) => controller.changeValue(value),
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => controller.resendOtp(),
                            child: Text(
                              "RESEND OTP",
                              style: AppTextStyle.appTextStyle(
                                  textColor: AppColors.colorDarkB,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  textDecoration: TextDecoration.underline
                              ),
                            ),
                          ),
                          Text(
                            controller.countdown > 0 ? controller.formattedTime : 'OTP Expired',
                            style: AppTextStyle.appTextStyle(
                                textColor: controller.countdown > 0 ? AppColors.colorDarkA : Colors.red, fontSize: 14, fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),

                      const Gap(24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                    activeColor: AppColors.colorDarkA,
                                    value: controller.rememberMe,
                                    side: MaterialStateBorderSide.resolveWith(
                                          (states) => BorderSide(
                                          width: 1.0,
                                          color: controller.rememberMe
                                              ? AppColors.colorDarkB
                                              : AppColors.colorDarkA),
                                    ),
                                    onChanged: (value) {
                                      controller.changeRememberMe();
                                    }),
                              ),
                              const Gap(8),
                              InkWell(
                                onTap: () => Get.toNamed(Routes.TERMS_AND_CONDITIONS),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "Agree ",
                                        style: AppTextStyle.appTextStyle(
                                            textColor: AppColors.colorDarkB,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    TextSpan(
                                        text: "TERMS & CONDITIONS",
                                        style: AppTextStyle.appTextStyle(
                                            textColor: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))
                                  ]),
                                ),
                              )
                            ],
                          ),
                          const Gap(20),
                          controller.isSubmit ? const CustomLoadingButton() : CustomButton(
                              onPressed: () {
                                if(controller.rememberMe){
                                  controller.matchVerificationCode();
                                }else {
                                  AppUtils.errorSnackBarForWeb("You don't accept terms & conditions");
                                }
                              },
                              buttonText: "Complete Your Registration"
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}
