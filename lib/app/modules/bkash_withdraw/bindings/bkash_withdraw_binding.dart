import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/bkash_withdraw/bkash_withdraw_repo.dart';
import 'package:ilu/app/modules/bkash_withdraw/controllers/bkash_withdraw_controller.dart';

class BkashWithdrawBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => BkashWithdrawRepo(apiService: Get.find()));
    Get.lazyPut(() => BkashWithdrawController(repo: Get.find()));
  }
}
