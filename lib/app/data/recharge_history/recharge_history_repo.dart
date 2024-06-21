import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class RechargeHistoryRepo{
  ApiServiceInterceptor apiService;
  RechargeHistoryRepo({required this.apiService});

  /// ------------------------- this method is used to get recharge history data
  Future<ApiResponseModel> getRechargeHistoryData() async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.rechargeHistoryEndPoint}";
    print("--------------- url: $url}");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.getRequest,
      headers: {
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      }
    );
    print("---------------- status code: ${responseModel.statusCode}");
    print("---------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }
}