import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/account_settings/account_setting_repo.dart';
import 'package:ilu/app/modules/account_settings/controllers/account_settings_controller.dart';

class AccountSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => AccountSettingRepo(apiService: Get.find()));
    Get.lazyPut(() => AccountSettingsController(repo: Get.find()));
  }
}
