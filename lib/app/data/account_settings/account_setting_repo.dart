import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class AccountSettingRepo{
  ApiServiceInterceptor apiService;

  AccountSettingRepo({required this.apiService});

  Future<ApiResponseModel> userChangePassword({required String oldPass, required String newPass, required String confirmPass}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.changePasswordEndPoint}";
    print("------------------ url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      },
      bodyParams: jsonEncode({
        "old_password": oldPass,
        "password": newPass,
        "confirm_password": confirmPass
      })
    );
    print("------------------ status code: ${responseModel.statusCode}");
    print("------------------ data: ${responseModel.responseJson}");

    return responseModel;
  }
}