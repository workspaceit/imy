import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/my_timeline/controllers/my_timeline_controller.dart';
import 'package:ilu/app/modules/my_timeline/views/mobile/my_timeline_mobile_view.dart';
import 'package:ilu/app/modules/my_timeline/views/web/my_timeline_web_view.dart';

class MyTimelineView extends StatefulWidget {
  const MyTimelineView({super.key});

  @override
  State<MyTimelineView> createState() => _MyTimelineViewState();
}

class _MyTimelineViewState extends State<MyTimelineView> {

  @override
  void initState() {
    final controller = Get.find<MyTimelineController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: MyTimeLineMobileView(),
      desktopUI: MyTimeLineWebView(),
    );
  }
}
