import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/notification/notificaton_repo.dart';
import 'package:ilu/app/modules/notification/controllers/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => NotificationRepo(apiService: Get.find()));
    Get.lazyPut(() => NotificationController(repo: Get.find()));
  }
}
