import 'package:get/get.dart';
import 'package:ilu/app/data/face_verification/face_verification_repo.dart';
import 'package:ilu/app/modules/face_verification/controllers/face_verification_controller.dart';

class FaceVerificationBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => FaceVerificationRepo(apiService: Get.find()));
    Get.lazyPut(() => FaceVerificationController(repo: Get.find()));
  }
}
