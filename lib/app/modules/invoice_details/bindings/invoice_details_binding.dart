import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/invoice/invoice_repo.dart';
import 'package:ilu/app/modules/invoice_details/controllers/invoice_details_controller.dart';

class InvoiceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => InvoiceRepo(apiService: Get.find()));
    Get.lazyPut(() => InvoiceDetailsController(repo: Get.find()));
  }
}
