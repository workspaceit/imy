import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class EditProfileRepo{

  ApiServiceInterceptor apiService;
  EditProfileRepo({required this.apiService});

  // ------------- this method is used for update profile ----------------------
  Future<ApiResponseModel> updateProfile({required String firstName, required String lastName, required String dob}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.updateProfileEndPoint}";

    print("-------------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      },
      bodyParams: jsonEncode({
        "first_name" : firstName,
        "last_name" : lastName,
        "date_of_birth" : dob
      })
    );

    print("----------------- response: ${responseModel.responseJson}");
    print("----------------- status code: ${responseModel.statusCode}");

    return responseModel;
  }

  // ------------------ this method is used for upload files -----------------------------
  Future<ApiResponseModel> uploadFiles({required List<String> imagePaths}) async{
    var headers = {
      'Authorization':'${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
    };

    var url = Uri.parse("${ApiUrlContainer.baseUrl}${ApiUrlContainer.uploadFilesEndPoint}");
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'file_type': 'profile_pic'
    });

    for (int i = 0; i < imagePaths.length; i++) {
      if (imagePaths.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'file', // API expects an array of images
          imagePaths[i],
        ));
      }
    }

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse).timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response.fromStream(streamedResponse)
    );

    return ApiResponseModel(response.statusCode, response.body);
  }

  // ------------------ web -----------------------
  Future<ApiResponseModel> webUploadFiles({required List<PlatformFile> imagePaths}) async{
    var headers = {
      'Authorization':'${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
    };

    var url = Uri.parse("${ApiUrlContainer.baseUrl}${ApiUrlContainer.uploadFilesEndPoint}");
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'file_type': 'profile_pic'
    });

    for (var image in imagePaths) {
      if (imagePaths.isNotEmpty) {
        request.files.add(http.MultipartFile.fromBytes(
          'file', // API expects an array of images
          image.bytes!,
          filename: image.name
        ));
      }
    }

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse).timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response.fromStream(streamedResponse)
    );

    return ApiResponseModel(response.statusCode, response.body);
  }

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

  // ------------------ this method is used for delete file ------------------------
  Future<ApiResponseModel> deleteProfileImage({required int profileImageId}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.deleteProfileImageEndPoint}$profileImageId/";
    print("------------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.deleteRequest,
      headers: {
        'Authorization' : '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      }
    );
    print("--------------------- status code: ${responseModel.statusCode}");

    return responseModel;
  }
}