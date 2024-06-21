import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

import '../../core/constants/api_service_constant.dart';

class HomeRepo {
  ApiServiceInterceptor apiService;
  HomeRepo({required this.apiService});

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

  /// ------------------ this method is used for get user data
  Future<ApiResponseModel> getUsersData({required int page, String keyword = "", String gender = "", int cityId = 0, String country = ""}) async {
    String url = kIsWeb ?
    "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?size=20&page=$page" :
    "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?page=$page";

    if (keyword != "") {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?keyword=$keyword&page=$page";
    }
    if (gender != "") {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?gender=$gender&page=$page";
    }
    if (cityId != 0) {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?city_id=$cityId&page=$page";
    }

    if (country != "") {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?country=${country.toLowerCase()}&page=$page";
    }

    if (keyword != "" && gender != "") {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?keyword=$keyword&gender=$gender&page=$page";
    }

    if (keyword != "" && cityId != 0) {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?keyword=$keyword&city_id=$cityId&page=$page";
    }

    if (keyword != "" && country != "") {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?keyword=$keyword&country=${country.toLowerCase()}&page=$page";
    }

    if (gender != "" && cityId != 0) {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?gender=$gender&city_id=$cityId&page=$page";
    }

    if (gender != "" && country != "") {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?gender=$gender&country=${country.toLowerCase()}&page=$page";
    }

    if (country != "" && cityId != 0) {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?country=${country.toLowerCase()}&city_id=$cityId&page=$page";
    }

    if (keyword != "" && country != "" && cityId != 0) {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?keyword=$keyword&country=${country.toLowerCase()}&city_id=$cityId&page=$page";
    }

    if (keyword != "" && gender != "" && cityId != 0) {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?keyword=$keyword&gender=$gender&city_id=$cityId&page=$page";
    }

    if (keyword != "" && gender != "" && country != "") {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?keyword=$keyword&gender=$gender&country=${country.toLowerCase()}&page=$page";
    }

    if (gender != "" && country != "" && cityId != 0) {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?gender=$gender&country=${country.toLowerCase()}&city_id=$cityId&page=$page";
    }

    if (keyword != "" && gender != "" && country != "" && cityId != 0) {
      url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserEndPoint}?keyword=$keyword&gender=$gender&country=${country.toLowerCase()}&city_id=$cityId&page=$page";
    }

    print("--------------------- url: $url");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization':
              '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        });
    print("------------------- status code: ${responseModel.statusCode}");
    print("------------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  // ----------------- this method is used to register device ---------------------
  Future<ApiResponseModel> registerDevice({required String deviceType, required String deviceIdentifier}) async {
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.registerDeviceEndPoint}";
    print("--------------------- url: $url");

    Map<String, String> body = {"device_type": deviceType, "identifier": deviceIdentifier};
    print("------------------- register device body: $body");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        },
        bodyParams: jsonEncode(body));
    print("----------------------- status code: ${responseModel.statusCode}");
    print("----------------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  Future<ApiResponseModel> getCity() async {
    ApiResponseModel responseModel = await apiService.requestToServer(
      requestUrl: "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getCityEndPoint}",
      requestMethod: ApiRequestMethod.getRequest,
    );

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
