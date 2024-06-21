import 'package:get/get.dart';

import '../controllers/details_images_controller.dart';

class DetailsImagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsImagesController>(
      () => DetailsImagesController(),
    );
  }
}
