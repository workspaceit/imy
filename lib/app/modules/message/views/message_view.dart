import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/message/controllers/message_controller.dart';
import 'package:ilu/app/modules/message/views/mobile/message_mobile_ui_view.dart';
import 'package:ilu/app/modules/message/views/web/message_web_ui_view.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<MessageController>().hasNext()){
        Get.find<MessageController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    final controller = Get.find<MessageController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getCurrentUserData();
      scrollController.addListener(scrollListener);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      mobileUI: MessageMobileUiView(scrollController: scrollController),
      desktopUI: MessageWebUiView(scrollController: scrollController),
    );
  }
}
