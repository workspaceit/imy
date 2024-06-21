import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/nagad_withdraw/nagad_withdraw_repo.dart';
import 'package:ilu/app/modules/nagad_withdraw/controllers/nagad_withdraw_controller.dart';

class NagadWithdrawBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => NagadWithdrawRepo(apiService: Get.find()));
    Get.lazyPut(() => NagadWithdrawController(repo: Get.find()));
  }
}
