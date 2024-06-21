import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/details_profile/details_profile_repo.dart';
import 'package:ilu/app/modules/details_profile/controllers/details_profile_controller.dart';

class DetailsProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => DetailsProfileRepo(apiService: Get.find()));
    Get.lazyPut(() => DetailsProfileController(repo: Get.find()));
  }
}
