import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/call_history/call_history_repo.dart';
import 'package:ilu/app/models/call_history/call_history_model.dart' as chm;
import 'package:ilu/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../../../models/profile/profile_response_model.dart';

class CallHistoryController extends GetxController {
  CallHistoryRepo repo;
  CallHistoryController({required this.repo});

  bool isLoading = false;
  int currentUserId = 0;

  initialState() async{
    isLoading = true;
    update();

    callHistoryList.clear();
    await getCurrentUserData();
    await loadCallHistory();

    isLoading = false;
    update();
  }

  /// ---------------- this method is used to get current user data
  Future<void> getCurrentUserData() async {

    ApiResponseModel responseModel = await repo.getUserProfile();

    if (responseModel.statusCode == 200) {
      ProfileResponseModel currentUserInfo = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      currentUserId = currentUserInfo.id ?? 0;
      update();
    } else if (responseModel.statusCode == 401 ||
        responseModel.statusCode == 403) {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  /// ---------------------- this method is used to initial state of the screen
  int page = 0;
  String nextPageUrl = "";
  int totalPage = 0;
  List<chm.Results> callHistoryList = [];

  Future<void> loadPaginationData() async{
    await loadCallHistory();
  }

  Future<void> loadCallHistory() async{
    // isCallHistoryLoading = true;
    // update();

    page = page + 1;

    if(page == 0){
      callHistoryList.clear();
    }

    ApiResponseModel responseModel = await repo.getCallHistory(page: page);

    if(responseModel.statusCode == 200){
      chm.CallHistoryModel callHistoryModel = chm.CallHistoryModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = callHistoryModel.next ?? "";
      totalPage = callHistoryModel.totalPage ?? 0;
      List<chm.Results>? tempList = callHistoryModel.results;
      if(tempList != null && tempList.isNotEmpty){
        callHistoryList.addAll(tempList);
        update();
      }
    }else if(responseModel.statusCode == 400){

    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){

    }else{

    }

    // isCallHistoryLoading = false;
    // update();
  }

  bool hasNext(){
    return nextPageUrl.isNotEmpty && nextPageUrl != null ? true : false;
  }

  String formattedDate(String value){
    String isoString = value;
    DateTime dateTimeUtc = DateTime.parse(isoString);
    //DateTime dateTimeLocal = dateTimeUtc.toLocal();
    String formattedDate = DateFormat('hh:mm a').format(dateTimeUtc);
    return formattedDate;
  }
}