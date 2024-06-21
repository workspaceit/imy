import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/data/withdraw_reward_point/withdraw_reward_point_repo.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';

class WithdrawRewardPointController extends GetxController {
  WithdrawRewardPointRepo repo;
  WithdrawRewardPointController({required this.repo});

  String paymentMethod = "";

  List<String> paymentMethodList = ["Bkash", "Nagad"];
  int selectedPayment = -1;

  selectPaymentMethod(int index){
    selectedPayment = index;
    paymentMethod = paymentMethodList[selectedPayment].toString().toLowerCase();
    repo.apiService.sharedPreferences.setString(LocalStorageHelper.paymentMethodKey, paymentMethod);
    print("------------------ select payment method: ${repo.apiService.sharedPreferences.getString(LocalStorageHelper.paymentMethodKey)}");
    update();
  }

  String rewardPoint = "";
  bool isLoading = false;

  Future<void> getUserData() async{
    isLoading = true;
    update();

    ApiResponseModel responseModel = await repo.getUserProfile();

    if(responseModel.statusCode == 200){
      ProfileResponseModel profileResponseModel = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      rewardPoint = "${(profileResponseModel.rewardPoints ?? 0) < 0 ? 0 : profileResponseModel.rewardPoints}";
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }

    isLoading = false;
    update();
  }
}
