import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/create_post/controllers/create_post_controller.dart';
import 'package:ilu/app/modules/create_post/views/mobile/create_post_mobile_ui_view.dart';
import 'package:ilu/app/modules/create_post/views/web/create_post_web_ui_view.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {

  @override
  void initState() {
    final controller = Get.find<CreatePostController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
      controller.videoControllers = [];
    });
    super.initState();
  }

  @override
  void dispose() {
    final controller = Get.find<CreatePostController>();
    if (controller.videoControllers != null) {
      for (var videoController in controller.videoControllers!) {
        videoController.dispose();
      }
    }
    controller.videoControllers = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: CreatePostMobileUiView(),
      desktopUI: CreatePostWebUiView(),
    );
  }
}
