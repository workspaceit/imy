import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/login/login_repo.dart';
import 'package:ilu/app/modules/login/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => LoginRepo(apiService: Get.find()));
    Get.lazyPut(() => LoginController(loginRepo: Get.find()));
  }
}
