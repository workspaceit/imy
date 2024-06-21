import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/block/block_repo.dart';
import 'package:ilu/app/modules/block_list/controllers/block_list_controller.dart';

class BlockListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => BlockRepo(apiService: Get.find()));
    Get.lazyPut(() => BlockListController(repo: Get.find()));
  }
}
