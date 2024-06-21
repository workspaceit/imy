import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class BlockRepo{
  ApiServiceInterceptor apiService;
  BlockRepo({required this.apiService});

  Future<ApiResponseModel> getFavoriteUser() async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getBlockUserEndPoint}";

    print("url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );

    print("status code: ${responseModel.statusCode}");
    print("data: ${responseModel.responseJson}");

    return responseModel;
  }

  Future<ApiResponseModel> unblockUser({required int id}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.unblockUserEndPoint}$id/";

    print("------------ url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );

    print("------------ status: ${responseModel.statusCode}");
    print("------------ data: ${responseModel.responseJson}");

    return responseModel;
  }
}