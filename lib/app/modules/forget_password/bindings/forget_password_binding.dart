import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/forget_password/forget_password_repo.dart';
import 'package:ilu/app/modules/forget_password/controllers/forget_password_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPasswordBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()), fenix: true);
    Get.lazyPut(() => ForgetPasswordRepo(apiServiceInterceptor: Get.find()));
    Get.lazyPut(() => ForgetPasswordController(repo: Get.find()));
  }
}
