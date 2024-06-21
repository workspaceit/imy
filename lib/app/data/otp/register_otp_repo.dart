import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class RegistrationOtpRepo{

  ApiServiceInterceptor apiService;
  RegistrationOtpRepo({required this.apiService});

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

  // ----------------------------- this method is used for matching verification code ---------------------------------
  Future<ApiResponseModel> matchVerificationCodeForLocal({required String phoneNumber, required String otpCode}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.matchVerificationCodeEndPoint}";
    print("-------------------url: $url");

    Map<String, String> body = {
      "phone_number": phoneNumber,
      "verification_code": otpCode
    };
    print("---------------- body: $body");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Content-Type': 'application/json'
      },
      bodyParams: jsonEncode(body)
    );
    print("--------------- status code: ${responseModel.statusCode}");
    print("--------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  // ----------------------------- this method is used for matching verification code ---------------------------------
  Future<ApiResponseModel> matchVerificationCodeForForeigner({required String email, required String otpCode}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.matchVerificationCodeEndPoint}";

    print("-------------------url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/json'
        },
        bodyParams: jsonEncode({
          "email": email,
          "verification_code": otpCode
        })
    );
    print("--------------- status code: ${responseModel.statusCode}");
    print("--------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }


  Future<ApiResponseModel> phoneNumberVerification({required String phoneNumber}) async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.sendVerificationCodeEndPoint}";

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/json'
        },
        bodyParams: jsonEncode({
          "phone_number" : phoneNumber
        })
    );

    return responseModel;
  }

  Future<ApiResponseModel> emailVerificationCode({required String email}) async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.sendVerificationCodeEndPoint}";

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/json'
        },
        bodyParams: jsonEncode({
          "email" : email
        })
    );

    return responseModel;
  }
}