import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/failed_response_model.dart';
import 'package:ilu/app/core/global/success_response_model.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/block/block_repo.dart';
import 'package:ilu/app/models/block/block_list_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';

class BlockListController extends GetxController {

  BlockRepo repo;
  BlockListController({required this.repo});

  bool isLoading = false;
  BlockListResponseModel model = BlockListResponseModel();

  List<Results> blockList = [];
  initialState() async{
    blockList.clear();
    isLoading = true;
    update();

    await getBlockUser();

    isLoading = false;
    update();
  }

  /// ------------------------- this method is used to get block user
  Future<void> getBlockUser() async{
    ApiResponseModel responseModel = await repo.getFavoriteUser();

    if(responseModel.statusCode == 200){
      model = BlockListResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Results>? tempList = model.results;
      if(tempList != null && tempList.isNotEmpty){
        blockList.addAll(tempList);
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{

    }
  }

  /// ------------------------ this method is used to unblock user
  unblockUser({required int id}) async{
    ApiResponseModel responseModel = await repo.unblockUser(id: id);

    if(responseModel.statusCode == 200){
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      Get.back();
      await initialState();
      FirebaseFirestore.instance.collection('chat_users')
          .doc(repo.apiService.sharedPreferences.getInt(LocalStorageHelper.userIdKey).toString())
          .collection('my_users').doc(id.toString()).update({
        "is_blocked": false
      });
      update();

      if(kIsWeb){
        AppUtils.successSnackBarForWeb(model.message ?? "");
      }else{
        AppUtils.successToastMessage(model.message ?? "");
      }
    }else if (responseModel.statusCode == 400){
      FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(kIsWeb){
        AppUtils.errorSnackBarForWeb(model.message ?? "");
      }else{
        AppUtils.errorToastMessage(model.message ?? "");
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else if (responseModel.statusCode == 404){
      FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(kIsWeb){
        AppUtils.errorSnackBarForWeb(model.message ?? "");
      }else{
        AppUtils.errorToastMessage(model.message ?? "");
      }
    }else{
      if(kIsWeb){
        AppUtils.errorSnackBarForWeb("Something went wrong. Try Again");
      }else{
        AppUtils.errorToastMessage("Something went wrong. Try Again");
      }
    }
  }
}
