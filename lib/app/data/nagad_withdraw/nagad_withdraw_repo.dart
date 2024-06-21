import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class NagadWithdrawRepo{
  ApiServiceInterceptor apiService;
  NagadWithdrawRepo({required this.apiService});

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

  Future<ApiResponseModel> nagadWithdrawRequest({
    required String paymentMethod,
    required String accountName,
    //required String accountNumber,
    required String mobileWalletNumber,
    required int points,
    required int amount,
    required String amountInWords
  }) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.nagadWithdrawEndPoint}";
    print("---------------- url: $url");

    Map<String, dynamic> bodyParams = {
      "payment_method": paymentMethod,
      "account_name" : accountName,
      //"account_number": accountNumber,
      "wallet_number": mobileWalletNumber,
      "points": points,
      "amount": amount,
      "amount_in_words": amountInWords
    };
    print("--------------- body: $bodyParams");

    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.postRequest,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        },
        bodyParams: jsonEncode(bodyParams)
    );
    print("-------------- status code: ${responseModel.statusCode}");
    print("-------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }
}