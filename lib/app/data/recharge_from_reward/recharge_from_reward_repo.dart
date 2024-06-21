import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class RechargeFromRewardRepo{
  ApiServiceInterceptor apiService;
  RechargeFromRewardRepo({required this.apiService});

  /// ----------------- this method is used to get user data
  Future<ApiResponseModel> getUserProfile() async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.userProfileEndPoint}";
    print("----------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );
    print("------------------- status code: ${responseModel.statusCode}");
    print("------------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  /// ----------------- this method is used to recharge from reward
  Future<ApiResponseModel> rechargeFromRewardBalance({required int rechargePoint}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.rechargeFromRewardEndPoint}";
    print("-------------------- url: $url");

    Map<String, int> body = {
      "points": rechargePoint
    };
    print("----------------- body: $body");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      bodyParams: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      }
    );
    print("----------------- status code: ${responseModel.statusCode}");
    print("----------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }
}