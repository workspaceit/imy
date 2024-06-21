import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class CallHistoryRepo{
  ApiServiceInterceptor apiService;
  CallHistoryRepo({required this.apiService});

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