import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/withdraw_reward_point/withdraw_reward_point_repo.dart';
import 'package:ilu/app/modules/withdraw_reward_point/controllers/withdraw_reward_point_controller.dart';

class WithdrawRewardPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => WithdrawRewardPointRepo(apiService: Get.find()));
    Get.lazyPut(() => WithdrawRewardPointController(repo: Get.find()));
  }
}
