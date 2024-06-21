import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/failed_response_model.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/nagad_withdraw/nagad_withdraw_repo.dart';
import 'package:ilu/app/models/default_setting/default_setting_response_model.dart';
import 'package:ilu/app/models/reward_withdraw/bkash_withdraw_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';

class NagadWithdrawController extends GetxController {
  NagadWithdrawRepo repo;
  NagadWithdrawController({required this.repo});

  TextEditingController nagadUsernameController = TextEditingController();
  TextEditingController mobileWalletController = TextEditingController();
  TextEditingController iluProfileIdController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController amountTextController = TextEditingController();

  final nagadForm = GlobalKey<FormState>();

  // ------------------------ this method is used to withdraw reward point from bkash -------------------------
  bool isSubmit = false;

  Future<void> withdrawRewardPointFromNagad() async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.nagadWithdrawRequest(
        paymentMethod: repo.apiService.sharedPreferences.getString(LocalStorageHelper.paymentMethodKey) ?? "",
        accountName: nagadUsernameController.text.trim(),
        //accountNumber: iluProfileIdController.text.trim(),
        points: repo.apiService.sharedPreferences.getInt(LocalStorageHelper.userRewardPointsKey) ?? 0,
        amount: int.parse(amountController.text.trim()),
        amountInWords: amountTextController.text.trim(),
        mobileWalletNumber: mobileWalletController.text.trim()
    );

    if(responseModel.statusCode == 201){
      BkashWithdrawResponseModel model = BkashWithdrawResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      // todo -> dialog
      showDialog(
          context: Get.context!,
          builder: (context) => CustomDialog(
            width: 400,
            dialogChild: Column(
              children: [
                Text(
                  "Thanks",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Gap(20),
                Text(
                  "We will send the amount to your account as soon as possible. Thanks for being with us.",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const Gap(24),
                CustomButton(
                    onPressed: (){
                      Get.back();
                      Get.offAndToNamed(Routes.HOME);
                    },
                    buttonText: "Go to HomePage"
                )
              ],
            ),
          )
      );
    }else if(responseModel.statusCode == 400){
      FailedResponseModel errorModel = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      kIsWeb ? AppUtils.errorSnackBarForWeb(errorModel.message ?? "") : AppUtils.errorToastMessage(errorModel.message ?? "");
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{
      if(kIsWeb){
        AppUtils.errorSnackBarForWeb("Something went wrong. Try again");
      }else{
        AppUtils.errorToastMessage("Something went wrong. Try again");
      }
    }


    clearData();
    isSubmit = false;
    update();
  }

  bool isLoading = false;

  loadData() async{
    isLoading = true;
    update();

    await getDefaultSetting();
    iluProfileIdController.text = repo.apiService.sharedPreferences.getString(LocalStorageHelper.currentUserIdKey) ?? "";

    isLoading = false;
    update();
  }

  clearData(){
    nagadUsernameController.text = "";
    mobileWalletController.text = "";
    amountTextController.text = "";
    amountController.text = "";
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
}
