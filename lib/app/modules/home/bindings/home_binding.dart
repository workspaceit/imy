import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/home/home_repo.dart';
import 'package:ilu/app/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => HomeRepo(apiService: Get.find()));
    Get.lazyPut(() => HomeController(homeRepo: Get.find()));
  }
}
