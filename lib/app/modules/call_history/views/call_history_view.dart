import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/call_history/controllers/call_history_controller.dart';
import 'package:ilu/app/modules/call_history/views/mobile/call_history_mobile_ui_view.dart';
import 'package:ilu/app/modules/call_history/views/web/call_history_web_ui_view.dart';

class CallHistoryView extends StatefulWidget {
  const CallHistoryView({super.key});

  @override
  State<CallHistoryView> createState() => _CallHistoryViewState();
}

class _CallHistoryViewState extends State<CallHistoryView> {
  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<CallHistoryController>().hasNext()){
        Get.find<CallHistoryController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    final controller = Get.find<CallHistoryController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
      scrollController.addListener(scrollListener);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      mobileUI: CallHistoryMobileUiView(scrollController: scrollController),
      desktopUI: CallHistoryWebUiView(scrollController: scrollController),
    );
  }
}
