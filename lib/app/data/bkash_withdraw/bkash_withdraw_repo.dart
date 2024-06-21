import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class BkashWithdrawRepo{
  ApiServiceInterceptor apiService;
  BkashWithdrawRepo({required this.apiService});

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

  Future<ApiResponseModel> bkashWithdrawRequest({
    required String paymentMethod,
    required String mobileWalletNumber,
    required int amount,
    required String amountInWords
  }) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.bkashWithdrawEndPoint}";
    print("---------------- url: $url");

    Map<String, dynamic> bodyParams = {
      "payment_method": paymentMethod,
      "wallet_number": mobileWalletNumber,
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