import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class DetailsProfileRepo{

  ApiServiceInterceptor apiService;

  DetailsProfileRepo({required this.apiService});

  // ----------- this method is used to get user details -------------
  Future<ApiResponseModel> getUserDetails({required int id}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserDetailsEndPoint}$id/";
    print("--------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.getRequest,
      headers: {
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      }
    );

    print("--------------- status: ${responseModel.statusCode}");
    print("--------------- response data: ${responseModel.responseJson}");


    return responseModel;
  }

  // --------------------- this method is used for make favorite image ------------------------
  Future<ApiResponseModel> makeFavoriteProfileImage({required int profileImageId}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.makeFavoriteImageEndPoint}$profileImageId/";
    print("------------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      }
    );

    print("------------- status: ${responseModel.statusCode}");
    print("------------- response: ${responseModel.responseJson}");
    return responseModel;
  }

  // --------------------- this method is used for remove favorite image ------------------------
  Future<ApiResponseModel> removeFavoriteProfileImage({required int profileImageId}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.removeFavoriteImageEndPoint}$profileImageId/";
    print("------------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      }
    );

    print("------------- status: ${responseModel.statusCode}");
    print("------------- response: ${responseModel.responseJson}");
    return responseModel;
  }

  // ------------- this method is used to report user ---------------
  Future<ApiResponseModel> reportUser({required int id, required String report}) async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.reportUserEndPoint}$id/";

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      },
      bodyParams: jsonEncode({
        "reason" : report
      })
    );
    return responseModel;
  }

  // ------------- this method is used to make favorite user ---------------
  Future<ApiResponseModel> makeUserFavorite({required int id}) async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.makeFavoriteUserEndPoint}$id/";

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        },
    );
    return responseModel;
  }

  // ------------- this method is used to make block user ---------------
  Future<ApiResponseModel> makeUserBlock({required int id}) async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.makeBlockUserEndPoint}$id/";

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      },
    );
    return responseModel;
  }

  // ------------- timeline ------------------
  Future<ApiResponseModel> getAllPost({required int userId}) async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getAllPostEndPoint}?user_id=$userId";

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );

    return responseModel;
  }

  // -------------- this method is used for like post -----------------------
  Future<ApiResponseModel> likePost({required int postId}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.likePostEndPoint}$postId/";

    print("Url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );

    print("response: ${responseModel.responseJson}");
    print("status: ${responseModel.statusCode}");

    return responseModel;
  }

  // -------------- this method is used for unlike post -----------------------
  Future<ApiResponseModel> unlikePost({required int postId}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.unlikePostEndPoint}$postId/";

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );

    return responseModel;
  }

  /// ---------------- this method is used to call agora token api
  Future<ApiResponseModel> callAgoraTokenAPI({required String channelName}) async {
    String url = "${ApiUrlContainer.baseUrl}/api/fetch-token/";
    print("-------------------- url: $url");

    Map<String, String> body = {
      "channel":  channelName
    };
    print("---------------- body: $body");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      },
      bodyParams: jsonEncode(body)
    );
    print("--------------- status code: ${responseModel.statusCode}");
    print("--------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }
}