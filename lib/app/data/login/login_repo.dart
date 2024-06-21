import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/constants/api_service_constant.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class LoginRepo{
  ApiServiceInterceptor apiService;

  LoginRepo({required this.apiService});

  /// ------------------ this method is used to login user
  Future<ApiResponseModel> userLogin({required String username, required String password}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.loginEndPoint}";
    print("------------------------ url: $url");

    Map<String, String> body = {
      "grant_type" : "password",
      "client_id" : clientId,
      "client_secret" : clientSecret,
      "username" : username,
      "password" : password
    };
    print("----------------- body params: $body");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      bodyParams: body
    );
    print("------------------- status code: ${responseModel.statusCode}");
    print("------------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  /// ------------------ this method is used to get user profile info
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

  /// -------------------- this method is used to get refresh token
  Future<ApiResponseModel> refreshToken({required String refreshToken}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.loginEndPoint}";
    print("---------------------- url: $url");

    Map<String, String> body = {
      "grant_type" : "refresh_token",
      "client_id" : clientId,
      "client_secret" : clientSecret,
      "refresh_token" : refreshToken,
    };
    print("------------------- body: $body");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        bodyParams: body
    );
    print("----------------- status code: ${responseModel.statusCode}");
    print("----------------- response body: ${responseModel.responseJson}");

    return responseModel;
  }
}