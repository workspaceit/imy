import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/post/create_post_repo.dart';

import '../controllers/create_post_controller.dart';

class CreatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => CreatePostRepo(apiService: Get.find()));
    Get.lazyPut(() => CreatePostController(repo: Get.find()));
  }
}
