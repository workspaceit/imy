import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';

class BankWithdrawRepo{
  ApiServiceInterceptor apiService;
  BankWithdrawRepo({required this.apiService});

  Future<ApiResponseModel> bankWithdrawRequest({
    required String paymentMethod,
    required String accountName,
    required String accountNumber,
    required String branch,
    required String routingNumber,
    required int points,
    required int amount,
    required String amountInWords
  }) async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.bankWithdrawEndPoint}";
    print("---------------- url: $url");

    Map<String, dynamic> bodyParams = {
      "payment_method": paymentMethod,
      "account_name" : accountName,
      "account_number": accountNumber,
      "branch": branch,
      "routing_number": routingNumber,
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