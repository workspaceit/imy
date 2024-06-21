import 'dart:async';
import 'dart:convert';
import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/failed_otp_response_model.dart';
import 'package:ilu/app/core/global/failed_response_model.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/otp/forget_password_otp_repo.dart';
import 'package:ilu/app/models/forget_password/check_reset_password_model.dart';
import 'package:ilu/app/models/forget_password/forget_password_verify_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';

class OtpVerificationController extends GetxController {

  ForgetPasswordOtpRepo repo;

  OtpVerificationController({required this.repo});

  int countdown = 300; // Change this to your desired countdown duration (seconds)
  Timer? timer;
  bool isResendEnabled = true;

  String get formattedTime {
    int minutes = (countdown / 60).floor();
    int seconds = countdown % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString()
        .padLeft(2, '0')}';
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
      repo.apiService.sharedPreferences.getString(LocalStorageHelper.userTypeKey) == "Bangladesh"
          ? forgetPasswordPhoneVerify()
          : forgetPasswordEmailVerify();
      countdown = 300; // Reset countdown
      isResendEnabled = false;
      startTimer();
    }
    update();
  }

  bool isLoading = false;
  String verificationCode = "";

  // -------------------- this method is used to check otp for email --------------------------
  Future<void> checkOtpForEmail() async {
    isLoading = true;
    update();

    String email = repo.apiService.sharedPreferences.getString(
        LocalStorageHelper.emailVerifyKey) ?? "";

    if (verificationCode.isEmpty) {
      kIsWeb ? AppUtils.errorSnackBarForWeb("Please enter OTP") : AppUtils
          .errorToastMessage("Please enter OTP");
    } else {
      ApiResponseModel responseModel = await repo.checkResetPasswordForEmail(
          otpCode: verificationCode, email: email);
      if (responseModel.statusCode == 200) {
        CheckResetPasswordModel model = CheckResetPasswordModel.fromJson(
            jsonDecode(responseModel.responseJson));
        await repo.apiService.sharedPreferences.setString(
            LocalStorageHelper.verificationCodeKey, verificationCode);
        kIsWeb
            ? AppUtils.successSnackBarForWeb("OTP verified successfully")
            : AppUtils.successToastMessage("OTP verified successfully");
        Get.offAndToNamed(Routes.NEW_PASSWORD);
      } else if (responseModel.statusCode == 400) {
        FailedOtpResponseModel model = FailedOtpResponseModel.fromJson(
            jsonDecode(responseModel.responseJson));
        kIsWeb ? AppUtils.errorSnackBarForWeb(model.message.toString()) : AppUtils
            .errorToastMessage(model.message.toString());
      }else if (responseModel.statusCode == 404) {
        FailedResponseModel model = FailedResponseModel.fromJson(
            jsonDecode(responseModel.responseJson));
        kIsWeb ? AppUtils.errorSnackBarForWeb("Please provide valid OTP") : AppUtils
            .errorToastMessage("Please provide valid OTP");
      } else {
        kIsWeb
            ? AppUtils.errorSnackBarForWeb("Something went wrong. Try again")
            : AppUtils.errorToastMessage("Something went wrong. Try again.");
      }
    }

    isLoading = false;
    update();
  }

  // ---------------------------- this method is used to check otp for phone number ------------------
  Future<void> checkOtpForPhoneNumber() async {
    isLoading = true;
    update();

    String phoneNumber = repo.apiService.sharedPreferences.getString(
        LocalStorageHelper.phoneNumberVerifyKey) ?? "";
    print("--------------- phone number: $phoneNumber");
    print("--------------- code: $verificationCode");

    if (verificationCode.isEmpty) {
      kIsWeb ? AppUtils.errorSnackBarForWeb("Please enter OTP") : AppUtils
          .errorToastMessage("Please enter OTP");
    } else {
      ApiResponseModel responseModel = await repo
          .checkResetPasswordForPhoneNumber(
          otpCode: verificationCode, phoneNumber: phoneNumber);
      if (responseModel.statusCode == 200) {
        CheckResetPasswordModel model = CheckResetPasswordModel.fromJson(
            jsonDecode(responseModel.responseJson));
        await repo.apiService.sharedPreferences.setString(
            LocalStorageHelper.verificationCodeKey, verificationCode);
        kIsWeb
            ? AppUtils.successSnackBarForWeb("OTP verified successfully")
            : AppUtils.successToastMessage("OTP verified successfully");
        Get.offAndToNamed(Routes.NEW_PASSWORD);
      }else if (responseModel.statusCode == 400) {
        FailedOtpResponseModel model = FailedOtpResponseModel.fromJson(
            jsonDecode(responseModel.responseJson));
        kIsWeb ? AppUtils.errorSnackBarForWeb(model.message.toString()) : AppUtils
            .errorToastMessage(model.message.toString());
      } else if (responseModel.statusCode == 404) {
        FailedResponseModel model = FailedResponseModel.fromJson(
            jsonDecode(responseModel.responseJson));
        kIsWeb ? AppUtils.errorSnackBarForWeb("${model.message}") : AppUtils
            .errorToastMessage("${model.message}");
      } else {
        kIsWeb
            ? AppUtils.errorSnackBarForWeb("Something went wrong. Try again")
            : AppUtils.errorToastMessage("Something went wrong. Try again.");
      }
    }

    isLoading = false;
    update();
  }

  // ------------- change otp field value ------------
  changeValue(String value) {
    verificationCode = value;
    update();
  }

  // ------------------- this method is used for verify email --------------------------
  bool isSubmit = false;

  Future<void> forgetPasswordEmailVerify() async {
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.emailVerification(
        email: repo.apiService.sharedPreferences.getString(
            LocalStorageHelper.emailVerifyKey) ?? "");

    if (responseModel.statusCode == 200) {
      ForgetPasswordVerifyResponseModel model = ForgetPasswordVerifyResponseModel
          .fromJson(jsonDecode(responseModel.responseJson));
      kIsWeb ? AppUtils.successSnackBarForWeb(
          model.message ?? "OTP code sent to your email") : AppUtils
          .successToastMessage(model.message ?? "OTP code sent to your email");
    } else {
      kIsWeb
          ? AppUtils.errorSnackBarForWeb("Something went wrong. Try Again")
          : AppUtils.errorToastMessage("Something went wrong. Try Again");
    }
    isSubmit = false;
    update();
  }

  // -------------------------- this method is used for verify phone number ----------------------
  Future<void> forgetPasswordPhoneVerify() async {
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.phoneNumberVerification(
        phoneNumber: repo.apiService.sharedPreferences.getString(
            LocalStorageHelper.phoneNumberVerifyKey) ?? ""
    );

    if (responseModel.statusCode == 200) {
      ForgetPasswordVerifyResponseModel model = ForgetPasswordVerifyResponseModel
          .fromJson(jsonDecode(responseModel.responseJson));
      kIsWeb ? AppUtils.successSnackBarForWeb(
          model.message ?? "OTP code sent to your phone") : AppUtils
          .successToastMessage(model.message ?? "OTP code sent to your phone");
    } else {
      kIsWeb
          ? AppUtils.errorSnackBarForWeb("Something went wrong. Try Again")
          : AppUtils.errorToastMessage("Something went wrong. Try Again");
    }

    isSubmit = false;
    update();
  }
}