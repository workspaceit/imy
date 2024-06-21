import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/call/audio_call_repo.dart';
import 'package:ilu/app/modules/audio_call/controllers/audio_call_controller.dart';

class AudioCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => AudioCallRepo(apiService: Get.find()));
    Get.lazyPut(() => AudioCallController(repo: Get.find()));
  }
}
