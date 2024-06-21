import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/registration/registration_repo.dart';
import 'package:ilu/app/modules/registration/controllers/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => RegistrationRepo(apiService: Get.find()));
    Get.lazyPut(() => RegistrationController(registrationRepo: Get.find()));
  }
}
