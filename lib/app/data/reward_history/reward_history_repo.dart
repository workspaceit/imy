import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class RewardHistoryRepo{
  ApiServiceInterceptor apiService;
  RewardHistoryRepo({required this.apiService});

  Future<ApiResponseModel> getRewardHistory() async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getRewardHistoryEndPont}";
    print("----------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.getRequest,
      headers: {
        'Authorization' : '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      }
    );

    print("------------ status: ${responseModel.statusCode}");
    print("------------ response: ${responseModel.responseJson}");

    return responseModel;
  }

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

  /// ---------------- this method is used to get data from default settings
  Future<ApiResponseModel> getDefaultSettingData() async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.defaultSettingsEndPoint}";
    print("-------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );
    print("------------------ status: ${responseModel.statusCode}");
    print("------------------ response body: ${responseModel.responseJson}");

    return responseModel;
  }
}