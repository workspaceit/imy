import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/post/timeline_repo.dart';
import 'package:ilu/app/modules/my_timeline/controllers/my_timeline_controller.dart';


class MyTimelineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => TimelineRepo(apiService: Get.find()));
    Get.lazyPut(() => MyTimelineController(repo: Get.find()));
  }
}
