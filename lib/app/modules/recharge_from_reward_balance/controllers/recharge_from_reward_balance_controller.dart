import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/recharge_from_reward/recharge_from_reward_repo.dart';
import 'package:ilu/app/routes/app_pages.dart';

class RechargeFromRewardBalanceController extends GetxController {
  RechargeFromRewardRepo repo;
  RechargeFromRewardBalanceController({required this.repo});

  TextEditingController rechargeAmountController = TextEditingController();
  bool isSubmit = false;

  /// ------------------ this method is used to recharge balance from reward points
  rechargeFromRewardPoints() async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.rechargeFromRewardBalance(
      rechargePoint: int.parse(rechargeAmountController.text.trim())
    );

    if(responseModel.statusCode == 200){
      kIsWeb ? AppUtils.successSnackBarForWeb("Balance Added Successfully") : AppUtils.successToastMessage("Balance Added Successfully");
      rechargeAmountController.text = "";
      Get.offAllNamed(Routes.HOME);
    }else if(responseModel.statusCode == 400){
      rechargeAmountController.text = "";
      kIsWeb ? AppUtils.errorSnackBarForWeb("Do not have enough reward balance") : AppUtils.errorToastMessage("Do not have enough reward balance");
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{
      rechargeAmountController.text = "";
      kIsWeb ? AppUtils.errorSnackBarForWeb("Internal Server Error") : AppUtils.errorToastMessage("Internal Server Error");
      Get.offAllNamed(Routes.HOME);
    }

    isSubmit = false;
    update();
  }
}
