import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';

class ForgetPasswordRepo{

  ApiServiceInterceptor apiServiceInterceptor;
  ForgetPasswordRepo({required this.apiServiceInterceptor});

  Future<ApiResponseModel> emailVerification({required String email}) async{
    print("---------------- email: $email");

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.forgetPasswordEmailEndPoint}";
    print("------------------- url: $url");

    ApiResponseModel responseModel = await apiServiceInterceptor.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Content-Type': 'application/json'
      },
      bodyParams: jsonEncode({
        "email" : email
      })
    );
    print("------------------- status code: ${responseModel.statusCode}");
    print("------------------- response data: ${responseModel.responseJson}");


    return responseModel;
  }

  Future<ApiResponseModel> phoneNumberVerification({required String phoneNumber}) async{
    print("----------------- phone number: $phoneNumber");

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.forgetPasswordPhoneEndPoint}";
    print("------------------- url: $url");

    ApiResponseModel responseModel = await apiServiceInterceptor.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/json'
        },
        bodyParams: jsonEncode({
          "phone_number" : phoneNumber
        })
    );
    print("------------------- status code: ${responseModel.statusCode}");
    print("------------------- url: ${responseModel.responseJson}");

    return responseModel;
  }
}