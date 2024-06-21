import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/chat/controllers/chat_controller.dart';
import 'package:ilu/app/modules/chat/views/mobile/chat_mobile_view.dart';
import 'package:ilu/app/modules/chat/views/web/chat_web_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    final controller = Get.find<ChatController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getCurrentUserData();
      controller.userDetailsData(id: controller.repo.apiService.sharedPreferences.getInt(LocalStorageHelper.detailsProfileUserIdKey) ?? -1);

      Future.delayed(const Duration(seconds: 1), (){
        controller.getMessages();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: ChatMobileView(),
      desktopUI: ChatWebView(),
    );
  }
}
