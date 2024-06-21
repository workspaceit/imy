import 'dart:io';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class CreatePostRepo{

  ApiServiceInterceptor apiService;
  CreatePostRepo({required this.apiService});

  Future<ApiResponseModel> createPost({required List<File> files, required String caption}) async{
    var url = Uri.parse("${ApiUrlContainer.baseUrl}${ApiUrlContainer.createPostEndPoint}");

    var headers = {
      'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
    };
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'caption': caption
    });

    for(int i = 0; i < files.length; i++){
      request.files.add(await http.MultipartFile.fromPath('files', files[i].path));
    }

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse)
        .timeout(const Duration(seconds: 10),
        onTimeout: () => http.Response.fromStream(streamedResponse));

    return ApiResponseModel(response.statusCode, response.body);
  }

  Future<ApiResponseModel> createWebPost({required List<PlatformFile> files, required String caption}) async{
    var url = Uri.parse("${ApiUrlContainer.baseUrl}${ApiUrlContainer.createPostEndPoint}");
    print("--------------------- url: $url");


    var headers = {
      'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
    };
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'caption': caption
    });

    for(var file in files){
      print("------------------ file: $file");
      request.files.add(http.MultipartFile.fromBytes('files', file.bytes!, filename: file.name));
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
}