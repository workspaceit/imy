import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class VideoCallRepo{
  ApiServiceInterceptor apiService;
  VideoCallRepo({required this.apiService});

  // ----------- this method is used to get user details -------------
  Future<ApiResponseModel> getUserDetails({required int id}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserDetailsEndPoint}$id";
    print("------------------ url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );
    print("------------------ status code: ${responseModel.statusCode}");
    print("------------------ response data: ${responseModel.responseJson}");

    return responseModel;
  }
}