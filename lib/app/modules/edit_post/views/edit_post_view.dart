import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/edit_post/controllers/edit_post_controller.dart';
import 'package:ilu/app/modules/edit_post/views/mobile/edit_post_mobile_ui_view.dart';
import 'package:ilu/app/modules/edit_post/views/web/edit_post_web_ui_view.dart';

class EditPostView extends StatefulWidget {
  const EditPostView({super.key});

  @override
  State<EditPostView> createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {

  @override
  void initState() {
    final controller = Get.find<EditPostController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: EditPostMobileUiView(),
      desktopUI: EditPostWebUiView(),
    );
  }
}
