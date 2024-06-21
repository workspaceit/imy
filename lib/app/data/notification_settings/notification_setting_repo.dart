import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class NotificationSettingRepo{
  ApiServiceInterceptor apiService;
  NotificationSettingRepo({required this.apiService});

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

  /// ---------------------- this method is used to notification setting
  Future<ApiResponseModel> setNotificationSettings({required bool enablePushNotification, required bool enableMessageNotification}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.updateProfileEndPoint}";
    print("---------------------- url: $url");

    Map<String, bool> bodyParams = {
      "enable_push_notification": enablePushNotification,
      "enable_message_notification": enableMessageNotification,
    };
    print("------------------ body: $bodyParams");
    
    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url, 
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      },
      bodyParams: jsonEncode(bodyParams)
    );
    print("-------------------- status code: ${responseModel.statusCode}");
    print("-------------------- response body: ${responseModel.responseJson}");

    return responseModel;
  }
}