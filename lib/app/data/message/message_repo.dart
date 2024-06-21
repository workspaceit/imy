import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class MessageRepo{
  ApiServiceInterceptor apiService;
  MessageRepo({required this.apiService});

  /// ------------------ this method is to get user profile info
  Future<ApiResponseModel> getUserProfile() async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.userProfileEndPoint}";
    print("------------------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );
    print("----------------- status code: ${responseModel.statusCode}");
    print("----------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  /// ----------- this method is used to get user details -------------
  Future<ApiResponseModel> getUserDetails({required int id}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserDetailsEndPoint}$id/";
    print("------------------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );
    print("----------------- status code: ${responseModel.statusCode}");
    print("----------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }


  callAgoraTokenAPI({required String channelName}) async {
    String url = "${ApiUrlContainer.baseUrl}/api/fetch-token/";

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        },
        bodyParams: {
          "channel":  channelName
        }
    );

    return responseModel;
  }

  // ------------- this method is used to make block user ---------------
  Future<ApiResponseModel> makeUserBlock({required int id}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.makeBlockUserEndPoint}$id/";
    print("------------------ url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      headers: {
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      },
    );
    print("------------------------- status code: ${responseModel.statusCode}");
    print("-------------------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  /// --------------- this method is used to get call history
  Future<ApiResponseModel> getCallHistory({required int page}) async{
    String url = "${ApiUrlContainer.baseUrl}/api/call-history/?page=$page";
    print("------------------ url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.getRequest,
      headers: {
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      },
    );
    print("------------------------- status code: ${responseModel.statusCode}");
    print("-------------------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }
}