import 'dart:async';
import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/success_response_model.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/new_password/new_password_repo.dart';
import 'package:ilu/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  NewPasswordRepo repo;
  NewPasswordController({required this.repo});

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();

  final newPasswordKey = GlobalKey<FormState>();

  // -------------------- reset password for caller ------------------
  bool isSubmit = false;
  Future<void> resetPasswordForCaller() async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.resetPasswordForCaller(
        newPassword: newPasswordController.text.trim(),
        confirmPassword: reEnterPasswordController.text.trim()
    );

    if(responseModel.statusCode == 200){
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      clearAllData();
      kIsWeb ? AppUtils.successSnackBarForWeb(
          model.message ?? "Your password changed successfully"
      ) : AppUtils.successToastMessage(model.message ?? "Your password changed successfully");
      repo.apiService.sharedPreferences.remove(LocalStorageHelper.userTypeKey);
      Get.offAllNamed(Routes.LOGIN);
    }else{
      kIsWeb ? AppUtils.errorSnackBarForWeb(
          "Something went wrong. Try again"
      ) : AppUtils.errorToastMessage("Something went wrong. Try again");
    }

    isSubmit = false;
    update();
  }

  // -------------------- reset password for video_call receiver ------------------
  Future<void> resetPasswordForReceiver() async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.resetPasswordForReceiver(
        newPassword: newPasswordController.text.trim(),
        confirmPassword: reEnterPasswordController.text.trim()
    );

    if(responseModel.statusCode == 200){
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      clearAllData();
      kIsWeb ? AppUtils.successSnackBarForWeb(
          model.message ?? "Your password changed successfully"
      ) : AppUtils.successToastMessage(model.message ?? "Your password changed successfully");
      repo.apiService.sharedPreferences.remove(LocalStorageHelper.userTypeKey);
      Get.offAllNamed(Routes.LOGIN);
    }else{
      kIsWeb ? AppUtils.errorSnackBarForWeb(
          "Something went wrong. Try again"
      ) : AppUtils.errorToastMessage("Something went wrong. Try again");
    }

    isSubmit = false;
    update();
  }

  // ------------- this method is used for clear data -------------
  void clearAllData(){
    newPasswordController.text = "";
    reEnterPasswordController.text = "";
    update();
  }


  // -------------- this method is used to check password length -------------------
  int passwordLength = 0;
  checkPasswordLength(String value) {
    passwordLength = value.length;
    update();
  }
}
