import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:ilu/app/core/constants/api_service_constant.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class ProfileRepo{

  ApiServiceInterceptor apiService;
  ProfileRepo({required this.apiService});

  // ------------------- this method is used for profile data --------------------------
  Future<ApiResponseModel> getUserProfile() async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.userProfileEndPoint}";

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );

    return responseModel;
  }

  // ----------------- this method is used for logout --------------------------
  Future<ApiResponseModel> userLogout() async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.logoutEndPoint}";
    print("-------------- url: $url");

    Map<String, dynamic> body = {
      "grant_type" : "refresh_token",
      "client_id" : clientId,
      "client_secret" : clientSecret,
      "token" : apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey),
      "device_type" : kIsWeb ? "web" : apiService.sharedPreferences.getString(LocalStorageHelper.deviceTypeKey)
    };
    print("-------------- body: $body");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        },
        bodyParams: body
    );

    print("status: ${responseModel.statusCode}");

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