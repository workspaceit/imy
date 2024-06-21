import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/reward_history/reward_history_repo.dart';

import '../controllers/reward_history_controller.dart';

class RewardHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => RewardHistoryRepo(apiService: Get.find()));
    Get.lazyPut(() => RewardHistoryController(repo: Get.find()));
  }
}
