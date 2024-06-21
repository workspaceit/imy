import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/withdraw_history/withdraw_history_repo.dart';

import '../controllers/withdraw_history_controller.dart';

class WithdrawHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => WithdrawHistoryRepo(apiService: Get.find()));
    Get.lazyPut(() => WithdrawHistoryController(repo: Get.find()));
  }
}
