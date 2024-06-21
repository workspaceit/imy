import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/call_history/call_history_repo.dart';

import '../controllers/call_history_controller.dart';

class CallHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => CallHistoryRepo(apiService: Get.find()));
    Get.lazyPut(() => CallHistoryController(repo: Get.find()));
  }
}
