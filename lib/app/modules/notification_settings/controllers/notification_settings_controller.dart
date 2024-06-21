import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/notification_settings/notification_setting_repo.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';

class NotificationSettingsController extends GetxController {
  NotificationSettingRepo repo;
  NotificationSettingsController({required this.repo});


  bool temporarilyPauseNotification = false;
  bool messageNotification = false;

  /// --------------------- this method is used to get user info
  bool isLoading = false;

  Future<void> getUserData() async{
    isLoading = true;
    update();

    ApiResponseModel responseModel = await repo.getUserProfile();

    if(responseModel.statusCode == 200){
      ProfileResponseModel profileResponseModel = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      temporarilyPauseNotification = profileResponseModel.enablePushNotification == false ? true : false;
      messageNotification = profileResponseModel.enableMessageNotification ?? false;
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }

    isLoading = false;
    update();
  }

  bool isSubmit = false;
  setNotificationSetting() async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.setNotificationSettings(
      enablePushNotification: temporarilyPauseNotification == true ? false : true,
      enableMessageNotification: messageNotification
    );

    if(responseModel.statusCode == 200){
      kIsWeb ? AppUtils.successSnackBarForWeb("Settings saved successfully") 
          : AppUtils.successToastMessage("Settings saved successfully") ;
      await getUserData();
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{
      kIsWeb ? AppUtils.errorSnackBarForWeb("Something went wrong. Try Again")
          : AppUtils.errorToastMessage("Something went wrong. Try Again");
    }

    isSubmit = false;
    update();
  }

  void setMessageNotification() {
    if(temporarilyPauseNotification == true){
      messageNotification = false;
      update();
    }else{
      if(messageNotification == true){
        messageNotification = false;
        update();
      }else{
        messageNotification = true;
        update();
      }
    }
  }

  void tempPauseNotification() {
    if(temporarilyPauseNotification == false){
      temporarilyPauseNotification = true;
      update();
    }else{
      temporarilyPauseNotification = false;
      update();
    }
  }
}
