import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/recharge_directly/recharge_directly_repo.dart';

import '../controllers/recharge_directly_controller.dart';

class RechargeDirectlyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => RechargeDirectlyRepo(apiService: Get.find()));
    Get.lazyPut(() => RechargeDirectlyController(repo: Get.find()));
  }
}
