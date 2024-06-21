import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class IluPointRepo{
  ApiServiceInterceptor apiService;
  IluPointRepo({required this.apiService});

  Future<ApiResponseModel> getIluPoint() async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.iluPackagesEndPoint}";

    print("-------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.getRequest,
      headers: {
        'Authorization' : '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      }
    );

    print("-------------- status: ${responseModel.statusCode}");
    print("-------------- response: ${responseModel.responseJson}");

    return responseModel;
  }
}