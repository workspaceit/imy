import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';

class ForgetPasswordOtpRepo{
  ApiServiceInterceptor apiService;
  ForgetPasswordOtpRepo({required this.apiService});

  Future<ApiResponseModel> checkResetPasswordForEmail({required String otpCode, required String email}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.checkResetPasswordEndPoint}?verification_code=$otpCode&email=$email";
    print("-------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.getRequest,
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print("-------------- status: ${responseModel.statusCode}");
    print("-------------- response: ${responseModel.responseJson}");

    return responseModel;
  }

  Future<ApiResponseModel> checkResetPasswordForPhoneNumber({required String otpCode, required String phoneNumber}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.checkResetPasswordEndPoint}?verification_code=$otpCode&phone_number=$phoneNumber";
    print("-------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Content-Type': 'application/json'
        }
    );

    print("-------------- status: ${responseModel.statusCode}");
    print("-------------- response: ${responseModel.responseJson}");

    return responseModel;
  }

  Future<ApiResponseModel> emailVerification({required String email}) async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.forgetPasswordEmailEndPoint}";
    print("------------------- url: $url");

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
    print("------------------ status code: ${responseModel.statusCode}");
    print("------------------ response data: ${responseModel.responseJson}");

    return responseModel;
  }

  Future<ApiResponseModel> phoneNumberVerification({required String phoneNumber}) async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.forgetPasswordPhoneEndPoint}";
    print("------------------- url: $url");

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
    print("------------------ status code: ${responseModel.statusCode}");
    print("------------------ response data: ${responseModel.responseJson}");

    return responseModel;
  }
}