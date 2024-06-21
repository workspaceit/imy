import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:ilu/app/core/global/api_url_container.dart';

class FaceVerificationRepo{

  ApiServiceInterceptor apiService;
  FaceVerificationRepo({required this.apiService});

  Future<ApiResponseModel> uploadVerificationImageForForeigner({required String imageFile, required String email}) async {
    var url = Uri.parse("${ApiUrlContainer.baseUrl}${ApiUrlContainer.verificationImageEndPoint}");

    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'email': email
    });

    request.files.add(await http.MultipartFile.fromPath('verification_image', imageFile));
    var streamedResponse = await request.send();

    http.Response response = await http.Response.fromStream(streamedResponse)
        .timeout(const Duration(seconds: 10),
        onTimeout: () => http.Response.fromStream(streamedResponse));

    return ApiResponseModel(response.statusCode, response.body);
  }

  Future<ApiResponseModel> uploadVerificationImageForLocal({required String imageFile, required String phoneNumber}) async {
    var url = Uri.parse("${ApiUrlContainer.baseUrl}${ApiUrlContainer.verificationImageEndPoint}");

    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'phone_number': phoneNumber
    });

    request.files.add(await http.MultipartFile.fromPath('verification_image', imageFile));
    var streamedResponse = await request.send();

    http.Response response = await http.Response.fromStream(streamedResponse)
        .timeout(const Duration(seconds: 10),
        onTimeout: () => http.Response.fromStream(streamedResponse));

    return ApiResponseModel(response.statusCode, response.body);
  }

  // -------------------- this method is used for send verification code ------------------
  Future<ApiResponseModel> sendEmailVerificationCode({required String email}) async{
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

  // -------------------- this method is used for send verification code ------------------
  Future<ApiResponseModel> sendPhoneVerificationCode({required String phone}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.sendVerificationCodeEndPoint}";

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/json'
        },
        bodyParams: jsonEncode({
          "phone_number": phone
        })
    );

    return responseModel;
  }
}