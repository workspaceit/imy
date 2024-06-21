import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/new_password/new_password_repo.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => NewPasswordRepo(apiService: Get.find()));
    Get.lazyPut(() => NewPasswordController(repo: Get.find()));
  }
}
