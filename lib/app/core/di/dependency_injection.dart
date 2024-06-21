import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependencyInjection{

  static initDependency() async{
    final prefs = await SharedPreferences.getInstance();

    Get.lazyPut(() => prefs, fenix: true);
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()), fenix: true);
  }
}