import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/face_verification/controllers/face_verification_controller.dart';
import 'package:ilu/app/modules/face_verification/views/mobile/face_verification_mobile_ui_view.dart';

class FaceVerificationView extends StatefulWidget {
  const FaceVerificationView({super.key});

  @override
  State<FaceVerificationView> createState() => _FaceVerificationViewState();
}

class _FaceVerificationViewState extends State<FaceVerificationView> {
  @override
  void initState() {
    final controller = Get.find<FaceVerificationController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initializeCamera();
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.find<FaceVerificationController>().cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: FaceVerificationMobileUiView(),
    );
  }
}
