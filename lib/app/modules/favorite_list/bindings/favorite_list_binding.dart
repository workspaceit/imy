import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/favorite/favorite_repo.dart';
import 'package:ilu/app/modules/favorite_list/controllers/favorite_list_controller.dart';

class FavoriteListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => FavoriteRepo(apiService: Get.find()));
    Get.lazyPut(() => FavoriteListController(repo: Get.find()));
  }
}
