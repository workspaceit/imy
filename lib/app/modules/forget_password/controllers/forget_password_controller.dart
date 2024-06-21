import 'dart:async';
import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/constants/country/country_list.dart';
import 'package:ilu/app/core/global/failed_response_model.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_static_text.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/forget_password/forget_password_repo.dart';
import 'package:ilu/app/models/forget_password/forget_password_verify_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';

class ForgetPasswordController extends GetxController{
  ForgetPasswordRepo repo;
  ForgetPasswordController({required this.repo});

  TextEditingController emailOrContactController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  bool isSubmit = false;

// ------------------- this method is used for verify email --------------------------
  Future<void> forgetPasswordEmailVerify() async {
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.emailVerification(email: emailOrContactController.text.trim());

    if(responseModel.statusCode == 200){
      ForgetPasswordVerifyResponseModel model = ForgetPasswordVerifyResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      await repo.apiServiceInterceptor.sharedPreferences.setString(LocalStorageHelper.emailVerifyKey, emailOrContactController.text.trim());
      await repo.apiServiceInterceptor.sharedPreferences.setString(LocalStorageHelper.userTypeKey, countryController.text.trim());
      update();
      emailOrContactController.text = "";
      showDialog(
          barrierDismissible: true,
          context: Get.context!,
          builder: (context) => CustomDialog(
            width: 400,
            dialogChild: Column(
              children: [
                Text(
                  AppStaticText.checkYourEmail.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.appTextStyle(
                      textColor: AppColors.colorDarkA,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const Gap(24),
                Text(
                  AppStaticText.sentYouAnOtpCheckEmail.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.appTextStyle(
                      textColor: AppColors.colorDarkB,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const Gap(24),
                CustomOutlineButton(
                    onPressed: () async {
                      Get.back();
                    },
                    buttonText: AppStaticText.close.tr
                )
              ],
            ),
          )
      );
      Future.delayed(const Duration(seconds: 1), (){
        Get.back();
        Get.toNamed(Routes.OTP_VERIFICATION);
      });
    } else if(responseModel.statusCode == 400){
      FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(kIsWeb){
        AppUtils.errorSnackBarForWeb(model.message ?? "");
      }else{
        AppUtils.errorToastMessage(model.message ?? "");
      }
      emailOrContactController.text = "";
    } else{
      if(kIsWeb){
        AppUtils.errorSnackBarForWeb("Something went wrong. Try Again");
      }else{
        AppUtils.errorToastMessage("Something went wrong. Try Again");
      }
      emailOrContactController.text = "";
    }

    countryController.text = "";
    isSubmit = false;
    update();
  }

  // -------------------------- this method is used for verify phone number ----------------------
  Future<void> forgetPasswordPhoneVerify() async {
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.phoneNumberVerification(
        phoneNumber: contactNumberController.text.trim().replaceFirst(RegExp(r'^0+'), '')
    );

    if(responseModel.statusCode == 200){
      ForgetPasswordVerifyResponseModel model = ForgetPasswordVerifyResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      await repo.apiServiceInterceptor.sharedPreferences.setString(LocalStorageHelper.phoneNumberVerifyKey, contactNumberController.text.trim().replaceFirst(RegExp(r'^0+'), ''));
      await repo.apiServiceInterceptor.sharedPreferences.setString(LocalStorageHelper.userTypeKey, countryController.text.trim());
      update();
      contactNumberController.text = "";
      showDialog(
          barrierDismissible: true,
          context: Get.context!,
          builder: (context) => CustomDialog(
            width: 400,
            dialogChild: Column(
              children: [
                Text(
                  AppStaticText.checkYourMessage.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.appTextStyle(
                      textColor: AppColors.colorDarkA,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const Gap(24),
                Text(
                  AppStaticText.sentYouAnOtpCheckMessage.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.appTextStyle(
                      textColor: AppColors.colorDarkB,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const Gap(24),
                CustomOutlineButton(
                    onPressed: () {
                      Get.back();
                    },
                    buttonText: AppStaticText.close
                )
              ],
            ),
          )
      );
      Future.delayed(const Duration(seconds: 1), (){
        Get.back();
        Get.toNamed(Routes.OTP_VERIFICATION);
      });
    }else if(responseModel.statusCode == 400){
      FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      kIsWeb ? AppUtils.errorSnackBarForWeb(model.message ?? "") : AppUtils.errorToastMessage(model.message ?? "");
      contactNumberController.text = "";
    } else{
      kIsWeb ? AppUtils.errorSnackBarForWeb("Something went wrong. Try Again") : AppUtils.errorToastMessage("Something went wrong. Try Again");
      contactNumberController.text = "";
    }

    countryController.text = "";
    isSubmit = false;
    update();
  }

  /// ---------------------- this method is used to get country data
  int selectedCountryIndex = -1;
  chooseCountry(int index){
    Get.back();
    selectedCountryIndex = index;
    countryController.text = countryList[selectedCountryIndex].name;
    update();
  }
}
