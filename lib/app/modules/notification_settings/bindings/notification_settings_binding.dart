import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/notification_settings/notification_setting_repo.dart';

import '../controllers/notification_settings_controller.dart';

class NotificationSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => NotificationSettingRepo(apiService: Get.find()));
    Get.lazyPut(() => NotificationSettingsController(repo: Get.find()));
  }
}
