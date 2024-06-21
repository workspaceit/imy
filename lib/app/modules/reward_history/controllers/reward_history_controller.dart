import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/reward_history/reward_history_repo.dart';
import 'package:ilu/app/models/default_setting/default_setting_response_model.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/models/reward_history/reward_history_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';

class RewardHistoryController extends GetxController {

  RewardHistoryRepo repo;
  RewardHistoryController({required this.repo});

  bool isLoading = false;
  RewardHistoryResponseModel model = RewardHistoryResponseModel();
  List<Results> rewardList = [];

  // ---------------- initial state -------------
  Future<void> initialState() async{
    rewardList.clear();
    isLoading = true;
    update();

    await getUserData();
    await getDefaultSetting();
    await loadData();

    isLoading = false;
    update();
  }

  // ---------------- this method is used for fetching reward history data ---------------
  Future<void> loadData() async{

    ApiResponseModel responseModel = await repo.getRewardHistory();

    if(responseModel.statusCode == 200){
      model = RewardHistoryResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Results>? tempList = model.results;

      if(tempList != null && tempList.isNotEmpty){
        rewardList.addAll(tempList);
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  /// ---------------------- this method is used to get user info
  int rechargeBalance = 0;
  int rewardPoints = 0;

  Future<void> getUserData() async{
    ApiResponseModel responseModel = await repo.getUserProfile();

    if(responseModel.statusCode == 200){
      ProfileResponseModel profileResponseModel = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      rechargeBalance = profileResponseModel.iluPoints ?? 0;
      if(rechargeBalance < 0){
        rechargeBalance = 0;
      }
      rewardPoints = profileResponseModel.rewardPoints ?? 0;
      if(rewardPoints < 0){
        rewardPoints = 0;
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
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
    if(rewardPoints < lowestWithdrawalAmount){
      kIsWeb
          ? AppUtils.warningSnackBarForWeb("You don't have enough reward balance for withdrawal")
          : AppUtils.warningToastMessage("You don't have enough reward balance for withdrawal");
    }else if(rewardPoints == 0){
      kIsWeb
          ? AppUtils.warningSnackBarForWeb("You don't have enough reward balance for withdrawal")
          : AppUtils.warningToastMessage("You don't have enough reward balance for withdrawal");
    }else{
      Get.toNamed(Routes.WITHDRAW_REWARD_POINT);
    }
  }
}
