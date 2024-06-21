import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/profile/profile_repo.dart';
import 'package:ilu/app/models/default_setting/default_setting_response_model.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{
  ProfileRepo repo;
  ProfileController({required this.repo});

  // ---------------------- initial stage for UI -------------------------------
  bool isLoading = false;
  initialStage() async{
    profileImages.clear();
    isLoading = true;
    update();

    await getUserData();
    await getDefaultSetting();

    isLoading = false;
    update();
  }

  // ------------------------------ this method is used for get user data -------------------------------
  String username = "";
  String userAge = "";
  String rewardPoint = "";
  String rechargeBalance = "";

  List<ProfileImages> profileImages = [];
  Future<void> getUserData() async{
    ApiResponseModel responseModel = await repo.getUserProfile();

    if(responseModel.statusCode == 200){
      ProfileResponseModel profileResponseModel = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      username = "${profileResponseModel.firstName} ${profileResponseModel.lastName}";
      userAge = "${profileResponseModel.age ?? 0} Years";
      rechargeBalance = "${(profileResponseModel.iluPoints ?? 0) < 0 ? 0 : profileResponseModel.iluPoints}";
      rewardPoint = "${(profileResponseModel.rewardPoints ?? 0) < 0 ? 0 : profileResponseModel.rewardPoints}";

      List<ProfileImages>? tempList = profileResponseModel.profileImages;
      if(tempList != null && tempList.isNotEmpty){
        profileImages.addAll(tempList);
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  // ------------------------------ this method is used for logout user -------------------------------------
  bool isSubmit = false;
  Future<void> logoutUser() async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.userLogout();

    if(responseModel.statusCode == 200){
      repo.apiService.sharedPreferences.remove(LocalStorageHelper.accessTokenKey);
      repo.apiService.sharedPreferences.clear();
      Get.offAllNamed(Routes.LOGIN);
      kIsWeb ? AppUtils.successSnackBarForWeb("Logout Successfully.") : AppUtils.successToastMessage("Logout Successfully.");
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }

    isSubmit = false;
    update();
  }

  // ----------------------------- pick image section ----------------------------------------------
  ImagePicker imagePicker = ImagePicker();
  List<File?> imageFileList = List.filled(5, null);

  pickImage(int index) async {
    final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      imageFileList[index] = File(pickImage.path);
    }
    update();
  }


  // ---------------------------- pick image from pc ---------------------------------------
  List<Uint8List?> pcImageFileList = List.filled(5, null);

  picImageFromPc(int index) async{
    final pickImage = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(pickImage != null){
      final file = pickImage.files.single.bytes;
      pcImageFileList[index] = file;
    }
    update();
  }

  /// ---------------- this method is used to default setting
  int lowestWithdrawalAmount = 0;
  List<DefaultSettingResponseModel> settings = [];

  Future<void> getDefaultSetting() async{
    ApiResponseModel responseModel = await repo.getDefaultSettingData();
    if(responseModel.statusCode == 200){
      List<dynamic> tempList = jsonDecode(responseModel.responseJson);
      if(tempList.isNotEmpty){
        settings = tempList.map((data) => DefaultSettingResponseModel.fromJson(data)).toList();
      }

      for(var settingData in settings){
        if(settingData.key == "lowest_withdrawal_amount"){
          lowestWithdrawalAmount = int.tryParse("${settingData.value}") ?? 0;
          update();
          print("------------ lowest withdrawal amount: $lowestWithdrawalAmount");
        }
      }
    }else if(responseModel.statusCode == 400){

    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{

    }
  }

  /// -------------------------- this method is used to withdraw reward balance
  void withdrawRewardPoints(){
    if(int.parse(rewardPoint) < lowestWithdrawalAmount){
      kIsWeb
          ? AppUtils.warningSnackBarForWeb("You don't have enough reward balance for withdrawal")
          : AppUtils.warningToastMessage("You don't have enough reward balance for withdrawal");
    }else if(int.parse(rewardPoint) == 0){
      kIsWeb
          ? AppUtils.warningSnackBarForWeb("You don't have enough reward balance for withdrawal")
          : AppUtils.warningToastMessage("You don't have enough reward balance for withdrawal");
    }else{
      Get.toNamed(Routes.WITHDRAW_REWARD_POINT);
    }
  }
}
