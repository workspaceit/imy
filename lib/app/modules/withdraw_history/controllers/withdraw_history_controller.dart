import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/withdraw_history/withdraw_history_repo.dart';
import 'package:ilu/app/models/withdraw_history/withdraw_history_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';

class WithdrawHistoryController extends GetxController{
  WithdrawHistoryRepo repo;
  WithdrawHistoryController({required this.repo});

  bool isLoading = false;
  WithdrawHistoryResponseModel model = WithdrawHistoryResponseModel();

  List<Results> withdrawHistoryList = [];

  // ----------------- initial state -------------
  initialState() async{
    withdrawHistoryList.clear();
    isLoading = true;
    update();

    await loadWithdrawHistoryData();

    isLoading = false;
    update();
  }

  loadWithdrawHistoryData() async{
    ApiResponseModel responseModel = await repo.getWithdrawHistory();

    if(responseModel.statusCode == 200){
      model = WithdrawHistoryResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Results>? tempList = model.results;
      if(tempList != null && tempList.isNotEmpty){
        withdrawHistoryList.addAll(tempList);
      }
    }else if(responseModel.statusCode == 400){

    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{
      if(kIsWeb){
        AppUtils.errorSnackBarForWeb("Something went wrong. Try again");
      }else{
        AppUtils.errorToastMessage("Something went wrong. Try again");
      }
    }
  }
}