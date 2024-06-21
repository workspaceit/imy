import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/edit_post/edit_post_repo.dart';
import 'package:ilu/app/modules/edit_post/controllers/edit_post_controller.dart';

class EditPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => EditPostRepo(apiService: Get.find()));
    Get.lazyPut(() => EditPostController(repo: Get.find()));
  }
}
