import 'dart:developer';
import 'dart:io';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:http/http.dart' as http;

class EditPostRepo{
  ApiServiceInterceptor apiService;

  EditPostRepo({required this.apiService});

  /// --------------------- this method is used to get profile data ----------------------
  Future<ApiResponseModel> getProfileData() async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.userProfileEndPoint}";
    log("------------------ profile url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.getRequest,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      }
    );

    log("----------------- status code: ${responseModel.statusCode}");
    log("----------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }
  
  /// ------------------------ this method is used for get specific post
  Future<ApiResponseModel> getAllPost() async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getAllPostEndPoint}${apiService.sharedPreferences.getInt(LocalStorageHelper.editPostIdKey)}/";
    log("--------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );
    log("--------------- status code: ${responseModel.statusCode}");
    log("--------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  /// ------------------------ this method is used to update post --------------
  Future<ApiResponseModel> updatePost({String? caption, List<File>? files, int? postImageId}) async{
    var url = Uri.parse("${ApiUrlContainer.baseUrl}${ApiUrlContainer.createPostEndPoint}${apiService.sharedPreferences.getInt(LocalStorageHelper.editPostIdKey)}/");
    print("--------------------- url: $url");

    var headers = {
      'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
    };
    var request = http.MultipartRequest('PATCH', url);

    if(caption != null){
      request.fields.addAll({
        'caption': caption
      });
    }

    if(postImageId != null){
      request.fields.addAll({
        'deleted_files': '$postImageId'
      });
    }

    if(files != null){
      for(int i = 0; i < files.length; i++){
        request.files.add(await http.MultipartFile.fromPath('files', files[i].path));
      }
    }

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse)
        .timeout(const Duration(seconds: 10),
        onTimeout: () => http.Response.fromStream(streamedResponse));

    print("--------------- status code: ${response.statusCode}");
    print("--------------- response data: ${response.body}");

    return ApiResponseModel(response.statusCode, response.body);
  }

  Future<ApiResponseModel> updateWebPost({String? caption, List<PlatformFile>? files, int? postImageId}) async{
    var url = Uri.parse("${ApiUrlContainer.baseUrl}${ApiUrlContainer.createPostEndPoint}${apiService.sharedPreferences.getInt(LocalStorageHelper.editPostIdKey)}/");
    print("--------------------- url: $url");


    var headers = {
      'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
    };
    var request = http.MultipartRequest('PATCH', url);

    if(caption != null){
      request.fields.addAll({
        'caption': caption
      });
    }

    if(files != null){
      for(var file in files){
        print("------------------ file: $file");
        request.files.add(http.MultipartFile.fromBytes('files', file.bytes!, filename: file.name));
      }
    }

    if(postImageId != null){
      request.fields.addAll({
        'deleted_files': '$postImageId'
      });
    }

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse)
        .timeout(const Duration(seconds: 10),
        onTimeout: () => http.Response.fromStream(streamedResponse));

    print("--------------- status code: ${response.statusCode}");
    print("--------------- response data: ${response.body}");

    return ApiResponseModel(response.statusCode, response.body);
  }

  /// ------------------------- this method is used to delete image
  Future<ApiResponseModel> deletePostImage({required int postImageId}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.deleteProfileImageEndPoint}$postImageId/";
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