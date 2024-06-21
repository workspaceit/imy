import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/otp/forget_password_otp_repo.dart';
import 'package:ilu/app/modules/otp_verification/controllers/otp_verification_controller.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()));
    Get.lazyPut(() => ForgetPasswordOtpRepo(apiService: Get.find()));
    Get.lazyPut(() => OtpVerificationController(repo: Get.find()));
  }
}
