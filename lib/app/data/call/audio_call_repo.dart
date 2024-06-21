import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class AudioCallRepo{

  ApiServiceInterceptor apiService;
  AudioCallRepo({required this.apiService});

  /// ------------------ this method is to get user profile info
  Future<ApiResponseModel> getUserProfile() async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.userProfileEndPoint}";
    print("------------------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );
    print("----------------- status code: ${responseModel.statusCode}");
    print("----------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  /// -------------------- this method is used to create call
  Future<ApiResponseModel> createCall({
    required String callDuration,
    required int pointSpent,
    required int pointGained,
    required String startTime,
    required String endTime,
    required int receiverId
  }) async{
    String url = "${ApiUrlContainer.baseUrl}/api/call-history/";
    print("------------------- url: $url");

    Map<String, dynamic> body = {
      "call_duration": callDuration,
      "points_spent": pointSpent,
      "points_gained": pointGained,
      "call_type": "audio_call",
      "start_time": startTime,
      "end_time": endTime,
      "receiver_id": receiverId
    };

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      },
      bodyParams: jsonEncode(body)
    );
    print("---------------- status code: ${responseModel.statusCode}");
    print("---------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  /// ---------------- this method is used to get data from default settings
  Future<ApiResponseModel> getDefaultSettingData() async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.defaultSettingsEndPoint}";
    print("-------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.getRequest,
      headers: {
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      }
    );
    print("------------------ status: ${responseModel.statusCode}");
    print("------------------ response body: ${responseModel.responseJson}");

    return responseModel;
  }
}