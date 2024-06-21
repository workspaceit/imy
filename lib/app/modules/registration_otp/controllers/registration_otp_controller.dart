import 'dart:async';
import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/global/failed_response_model.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/otp/register_otp_repo.dart';
import 'package:ilu/app/models/forget_password/forget_password_verify_response_model.dart';
import 'package:ilu/app/models/login/login_response_model.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';

class RegistrationOtpController extends GetxController {
  RegistrationOtpRepo repo;
  RegistrationOtpController({required this.repo});

  int countdown = 300; // Change this to your desired countdown duration (seconds)
  Timer? timer;
  bool isResendEnabled = true;

  String get formattedTime {
    int minutes = (countdown / 60).floor();
    int seconds = countdown % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }


  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
      } else {
        isResendEnabled = true;
        timer.cancel();
      }
      update();
    });
  }

  void resendOtp() {
    if (isResendEnabled) {
      repo.apiService.sharedPreferences.getString(LocalStorageHelper.userTypeKey) == "bangladesh"
          ? forgetPasswordPhoneVerify()
          : forgetPasswordEmailVerify();
      countdown = 300; // Reset countdown
      isResendEnabled = false;
      startTimer();
    }
    update();
  }

  bool rememberMe = false;
  changeRememberMe() {
    rememberMe = !rememberMe;
    update();
  }


  bool isSubmit = false;
  String currentText = "";
  String accessToken = "";
  String tokenType = "";

  // ---------------------------------- this method is used for match verification code ----------------------------
  matchVerificationCode() async {
    isSubmit = true;
    update();
    if(repo.apiService.sharedPreferences.getString(LocalStorageHelper.userTypeKey) == "Bangladesh"){
      String phoneNumber = repo.apiService.sharedPreferences.getString(LocalStorageHelper.phoneNumberKey) ?? "";
      print("-------------- phone number: $phoneNumber");

      if(currentText.isEmpty){
        kIsWeb ? AppUtils.errorSnackBarForWeb("Please Provide OTP") : AppUtils.errorToastMessage("Please Provide OTP");
      }else{
        ApiResponseModel responseModel = await repo.matchVerificationCodeForLocal(
            phoneNumber: phoneNumber,
            otpCode: currentText
        );

        if(responseModel.statusCode == 200){
          LoginResponseModel model = LoginResponseModel.fromJson(jsonDecode(responseModel.responseJson));
          accessToken = model.accessToken ?? "";
          tokenType = model.tokenType ?? "";

          // store data in local storage
          await repo.apiService.sharedPreferences.setString(LocalStorageHelper.accessTokenKey, accessToken);
          await repo.apiService.sharedPreferences.setString(LocalStorageHelper.tokenTypeKey, tokenType);
          await getUserData();

          if(accessToken == "" || accessToken.isEmpty){
            Get.offAllNamed(Routes.LOGIN);
          } else{
            showDialog(context: Get.context!, builder: (context) => CustomDialog(
              width: 400,
              dialogChild: Column(
                children: [
                  Text(
                    "Thanks!",
                    style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const Gap(20),
                  Text(
                    "We have received your request. We will shortly notify you after verifying your information. Thanks.",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.appTextStyle(
                        textColor: AppColors.colorDarkB,
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ));
            Timer(const Duration(seconds: 1), (){
              Get.offAllNamed(Routes.HOME);
            });
          }

        }else{
          FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
          kIsWeb ? AppUtils.errorSnackBarForWeb(model.message ?? "") : AppUtils.errorToastMessage(model.message ?? "");
        }
      }
    }else{
      String email = repo.apiService.sharedPreferences.getString(LocalStorageHelper.emailKey) ?? "";
      print("-------------- email: $email");

      if(currentText.isEmpty){
        kIsWeb ? AppUtils.errorSnackBarForWeb("Please Provide OTP") : AppUtils.errorToastMessage("Please Provide OTP");
      }else{
        ApiResponseModel responseModel = await repo.matchVerificationCodeForForeigner(
            email: email,
            otpCode: currentText
        );

        if(responseModel.statusCode == 200){
          LoginResponseModel model = LoginResponseModel.fromJson(jsonDecode(responseModel.responseJson));
          accessToken = model.accessToken ?? "";
          tokenType = model.tokenType ?? "";

          // store data in local storage
          await repo.apiService.sharedPreferences.setString(LocalStorageHelper.accessTokenKey, accessToken);
          await repo.apiService.sharedPreferences.setString(LocalStorageHelper.tokenTypeKey, tokenType);
          await getUserData();

          if(accessToken == "" || accessToken.isEmpty){
            Get.offAllNamed(Routes.LOGIN);
          } else{
            showDialog(context: Get.context!, builder: (context) => CustomDialog(
              width: 400,
              dialogChild: Column(
                children: [
                  Text(
                    "Thanks!",
                    style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const Gap(20),
                  Text(
                    "We have received your request. We will shortly notify you after verifying your information. Thanks.",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.appTextStyle(
                        textColor: AppColors.colorDarkB,
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ));
            Timer(const Duration(seconds: 1), (){
              Get.offAllNamed(Routes.HOME);
            });
          }

        }else{
          FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
          kIsWeb ? AppUtils.errorSnackBarForWeb(model.message ?? "") : AppUtils.errorToastMessage(model.message ?? "");
        }
      }
    }

    isSubmit = false;
    update();
  }

  // ------------------- send otp -----------------------
  Future<void> forgetPasswordPhoneVerify() async {
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.phoneNumberVerification(
        phoneNumber: repo.apiService.sharedPreferences.getString(LocalStorageHelper.phoneNumberKey) ?? ""
    );

    if(responseModel.statusCode == 200){
      ForgetPasswordVerifyResponseModel model = ForgetPasswordVerifyResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      kIsWeb ? AppUtils.successSnackBarForWeb(model.message ?? "OTP code sent to your phone") : AppUtils.successToastMessage(model.message ?? "OTP code sent to your phone");
    }else{
      kIsWeb ? AppUtils.errorSnackBarForWeb("Something went wrong. Try Again") : AppUtils.errorToastMessage("Something went wrong. Try Again");
    }

    isSubmit = false;
    update();
  }

  Future<void> forgetPasswordEmailVerify() async {
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.emailVerificationCode(
        email: repo.apiService.sharedPreferences.getString(LocalStorageHelper.emailKey) ?? ""
    );

    if(responseModel.statusCode == 200){
      ForgetPasswordVerifyResponseModel model = ForgetPasswordVerifyResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      kIsWeb ? AppUtils.successSnackBarForWeb(model.message ?? "OTP code sent to your email") : AppUtils.successToastMessage(model.message ?? "OTP code sent to your email");
    }else{
      kIsWeb ? AppUtils.errorSnackBarForWeb("Something went wrong. Try Again") : AppUtils.errorToastMessage("Something went wrong. Try Again");
    }

    isSubmit = false;
    update();
  }

  changeValue(String value){
    currentText = value;
    update();
  }

  // -------------------------- get user method -----------------
  String username = "";
  String dateOfBirth = "";
  String gender = "";
  String profileImage = "";
  String currentUserId = "";
  int id = 0;
  //String userType = "";
  int iluPoints = 0;

  List<ProfileImages> profileImages = [];

  Future<void> getUserData() async{
    ApiResponseModel responseModel = await repo.getUserProfile();

    if(responseModel.statusCode == 200){
      ProfileResponseModel profileResponseModel = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      username = "${profileResponseModel.firstName} ${profileResponseModel.lastName}";
      dateOfBirth = profileResponseModel.dateOfBirth ?? "";
      gender = profileResponseModel.gender ?? "";
      profileImages = profileResponseModel.profileImages ?? [];
      currentUserId = profileResponseModel.uniqueId ?? "";
      id = profileResponseModel.id ?? 0;
      iluPoints = profileResponseModel.iluPoints ?? 0;

      if(profileImages.isNotEmpty == true){
        profileImage = "${ApiUrlContainer.baseUrl}${profileImages[0].file}";
      }
      //await repo.apiService.sharedPreferences.setString(LocalStorageHelper.typeOfUserKey, userType);
      await repo.apiService.sharedPreferences.setString(LocalStorageHelper.userNameKey, username);
      await repo.apiService.sharedPreferences.setString(LocalStorageHelper.userDobKey, dateOfBirth);
      await repo.apiService.sharedPreferences.setString(LocalStorageHelper.userGenderKey, gender);
      await repo.apiService.sharedPreferences.setString(LocalStorageHelper.profileImageKey, profileImage);
      await repo.apiService.sharedPreferences.setString(LocalStorageHelper.currentUserIdKey, currentUserId);
      await repo.apiService.sharedPreferences.setInt(LocalStorageHelper.userILUPointsKey, iluPoints < 0 ? 0 : iluPoints);

      await repo.apiService.sharedPreferences.setInt(LocalStorageHelper.idOfCurrentUserKey, id);
    }else{

    }

    update();
  }
}
