import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class NewPasswordRepo{

  ApiServiceInterceptor apiService;
  NewPasswordRepo({required this.apiService});

  Future<ApiResponseModel> resetPasswordForCaller({required String newPassword, required String confirmPassword}) async{

    print("---------------- new password: $newPassword");
    print("---------------- new password: $confirmPassword");

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.resetPasswordEndPoint}";

    print("--------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Content-Type': 'application/json'
      },
      bodyParams: jsonEncode({
        "email": apiService.sharedPreferences.getString(LocalStorageHelper.emailVerifyKey),
        "verification_code": apiService.sharedPreferences.getString(LocalStorageHelper.verificationCodeKey),
        "password": newPassword,
        "confirm_password": confirmPassword
      })
    );

    print("-------------- status: ${responseModel.statusCode}");
    print("-------------- response: ${responseModel.responseJson}");

    return responseModel;
  }

  Future<ApiResponseModel> resetPasswordForReceiver({required String newPassword, required String confirmPassword}) async{

    print("---------------- new password: $newPassword");
    print("---------------- new password: $confirmPassword");

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.resetPasswordEndPoint}";

    print("--------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/json'
        },
        bodyParams: jsonEncode({
          "phone_number": apiService.sharedPreferences.getString(LocalStorageHelper.phoneNumberVerifyKey),
          "verification_code": apiService.sharedPreferences.getString(LocalStorageHelper.verificationCodeKey),
          "password": newPassword,
          "confirm_password": confirmPassword
        })
    );

    print("-------------- status: ${responseModel.statusCode}");
    print("-------------- response: ${responseModel.responseJson}");

    return responseModel;
  }
}