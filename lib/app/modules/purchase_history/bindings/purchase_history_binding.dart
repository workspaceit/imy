import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/recharge_history/recharge_history_repo.dart';
import 'package:ilu/app/modules/purchase_history/controllers/purchase_history_controller.dart';

class PurchaseHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => RechargeHistoryRepo(apiService: Get.find()));
    Get.lazyPut(() => PurchaseHistoryController(repo: Get.find()));
  }
}
