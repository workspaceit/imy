import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/recharge_from_reward/recharge_from_reward_repo.dart';

import '../controllers/recharge_from_reward_balance_controller.dart';

class RechargeFromRewardBalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => RechargeFromRewardRepo(apiService: Get.find()));
    Get.lazyPut(() => RechargeFromRewardBalanceController(repo: Get.find()));
  }
}
