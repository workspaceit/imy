import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/recharge_history/recharge_history_repo.dart';
import 'package:ilu/app/models/recharge_balance/recharge_history_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

class PurchaseHistoryController extends GetxController {
  RechargeHistoryRepo repo;
  PurchaseHistoryController({required this.repo});

  bool isLoading = false;

  /// ---------------- initial state
  initialState() async{
    isLoading = true;
    update();
    rechargeHistories.clear();

    await loadRechargeHistoryData();

    isLoading = false;
    update();
  }

  /// ------------------ this method is used to load data
  RechargeHistoryResponseModel model = RechargeHistoryResponseModel();
  List<Results> rechargeHistories = [];
  Future<void> loadRechargeHistoryData() async{
    ApiResponseModel responseModel = await repo.getRechargeHistoryData();
    if(responseModel.statusCode == 200){
      model = RechargeHistoryResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Results>? tempList = model.results;
      if(tempList != null && tempList.isNotEmpty){
        rechargeHistories.addAll(tempList);
      }
    }else if(responseModel.statusCode == 400){

    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else if(responseModel.statusCode == 404){

    }else{

    }
  }

  /// ----------------------------- this method is used to format date
  String formatDateTime(String value){
    DateTime dateTime = DateTime.parse(value); // Parse the date string
    String formattedDate = DateFormat('d MMMM, yyyy').format(dateTime);
    String formattedTime = DateFormat('hh:mm').format(dateTime);
    return "$formattedDate  •  $formattedTime";
  }
}
