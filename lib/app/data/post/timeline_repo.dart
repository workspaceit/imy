import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class TimelineRepo{

  ApiServiceInterceptor apiService;
  TimelineRepo({required this.apiService});

  // ------------------ this method is used for fetching all post ----------------------
  Future<ApiResponseModel> getAllPost() async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getAllPostEndPoint}";
    print("--------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.getRequest,
      headers: {
        'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
      }
    );
    print("--------------- status code: ${responseModel.statusCode}");
    print("--------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  // ------------------ this method is used for deleting specific post -------------------
  Future<ApiResponseModel> deletePost({required int postId}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.deletePostEndPoint}$postId/";
    print("--------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.deleteRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );
    print("--------------- status code: ${responseModel.statusCode}");
    print("--------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  // ------------------------ this method is used to see people who liked on the post -----------------------------
  Future<ApiResponseModel> getPostLikedUsers({required int postId}) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.postLikedUsersEndPoint}$postId/";
    print("--------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        }
    );
    print("--------------- status code: ${responseModel.statusCode}");
    print("--------------- response data: ${responseModel.responseJson}");

    return responseModel;
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