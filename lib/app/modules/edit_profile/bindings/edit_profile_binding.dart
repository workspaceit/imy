import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/profile/edit_profile_repo.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => EditProfileRepo(apiService: Get.find()));
    Get.lazyPut(() => EditProfileController(repo: Get.find()));
  }
}
