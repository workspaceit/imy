import 'package:get/get.dart';
import 'package:ilu/app/data/otp/register_otp_repo.dart';
import 'package:ilu/app/modules/registration_otp/controllers/registration_otp_controller.dart';

class RegistrationOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationOtpRepo(apiService: Get.find()));
    Get.lazyPut(() => RegistrationOtpController(repo: Get.find()));
  }
}
