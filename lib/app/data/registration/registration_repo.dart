import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class RegistrationRepo{

  ApiServiceInterceptor apiService;

  RegistrationRepo({required this.apiService});

  /// -------------------------- this method is used to register foreign user
  Future<ApiResponseModel> userRegistrationForForeignUser({
    required String firstName,
    required String lastName,
    required String gender,
    required String dateOfBirth,
    required String country,
    required String email,
    required String password,
    required String confirmPassword,
  }) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.registrationEndPont}";
    print("---------------- url: $url");

    Map<String, dynamic> bodyParams = {
      "first_name": firstName,
      "last_name": lastName,
      "gender": gender.toLowerCase(),
      "date_of_birth": dateOfBirth,
      "country": country.toLowerCase(),
      "email": email,
      "password": password,
      "confirm_password": confirmPassword,
    };

    print("--------------------- body: $bodyParams");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Content-Type': 'application/json'
      },
      bodyParams: jsonEncode(bodyParams)
    );

    print("response data: ${responseModel.responseJson}");
    print("response status: ${responseModel.statusCode}");

    return responseModel;
  }

  /// -------------------------- this method is used to register foreign user
  Future<ApiResponseModel> userRegistrationForLocalUser({
    required String firstName,
    required String lastName,
    required String gender,
    required String dateOfBirth,
    required String country,
    required String password,
    required String confirmPassword,
    required int cityId,
    required String phoneNumber,
    required String phoneCode
  }) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.registrationEndPont}";
    print("---------------- url: $url");

    Map<String, dynamic> bodyParams = {
      "first_name": firstName,
      "last_name": lastName,
      "gender": gender.toLowerCase(),
      "date_of_birth": dateOfBirth,
      "country": country.toLowerCase(),
      "city_id": cityId,
      "phone_number": phoneNumber,
      "phone_code": phoneCode.toString().replaceFirst(RegExp(r'^0+'), ''),
      "password": password,
      "confirm_password": confirmPassword,
    };

    print("--------------------- body: $bodyParams");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/json'
        },
        bodyParams: jsonEncode(bodyParams)
    );

    print("response data: ${responseModel.responseJson}");
    print("response status: ${responseModel.statusCode}");

    return responseModel;
  }

  Future<ApiResponseModel> getCity() async{

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getCityEndPoint}",
      requestMethod: ApiRequestMethod.getRequest,
    );

    return responseModel;
  }


  // -------------------- this method is used for send verification code ------------------
  Future<ApiResponseModel> sendVerificationCode({required String phoneNumber}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.sendVerificationCodeEndPoint}";

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/json'
        },
        bodyParams: jsonEncode({
          "phone_number": phoneNumber
        })
    );

    return responseModel;
  }

  // -------------------- this method is used for send verification code ------------------
  Future<ApiResponseModel> sendVerificationCodeEmail({required String email}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.sendVerificationCodeEndPoint}";

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/json'
        },
        bodyParams: jsonEncode({
          "email": email
        })
    );

    return responseModel;
  }
}