import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/failed_response_model.dart';
import 'package:ilu/app/core/global/success_response_model.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/favorite/favorite_repo.dart';
import 'package:ilu/app/models/favorite/favorite_list_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';

class FavoriteListController extends GetxController {
  FavoriteRepo repo;
  FavoriteListController({required this.repo});

  // ------------------ declare essential variables --------------------------
  bool isLoading = false;
  FavoriteListResponseModel model = FavoriteListResponseModel();
  List<Results> favoriteList = [];

  // ----------------- initial stage ---------------------------------------
  initialState() async{
    favoriteList.clear();
    isLoading = true;
    update();

    await getFavoriteUser();

    isLoading = false;
    update();
  }

  // ----------------------- this method is used to get favorite user data ---------------------
  Future<void> getFavoriteUser() async{
    ApiResponseModel responseModel = await repo.getFavoriteUser();

    if(responseModel.statusCode == 200){
      model = FavoriteListResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Results>? tempList = model.results;
      if(tempList != null && tempList.isNotEmpty){
        favoriteList.addAll(tempList);
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{

    }
  }

  // ---------------------- this method is used to delete favorite user ------------------------
  deleteFavoriteUser({required int id}) async{
    ApiResponseModel responseModel = await repo.deleteFavoriteUser(id: id);

    if(responseModel.statusCode == 200){
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      await initialState();
      if(kIsWeb){
        AppUtils.successSnackBarForWeb(model.message ?? "Remove user from favorite");
      }else{
        AppUtils.successToastMessage(model.message ?? "Remove user from favorite");
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
