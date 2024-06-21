import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/core/utils/agora_settings.dart';
import 'package:ilu/app/modules/audio_call/controllers/audio_call_controller.dart';
import 'package:ilu/app/modules/audio_call/views/mobile/audio_call_mobile_view.dart';
import 'package:ilu/app/modules/audio_call/views/web/audio_call_web_view.dart';

class AudioCallView extends StatefulWidget {
  const AudioCallView({super.key});

  @override
  State<AudioCallView> createState() => _AudioCallViewState();
}

class _AudioCallViewState extends State<AudioCallView> {

  String channelID = "";
  String userProfileImage = "";

  @override
  void initState() {
    channelID = Get.arguments[0];
    userProfileImage = Get.arguments[1];

    final controller = Get.find<AudioCallController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserData();
      controller.setUpAgoraVoiceSdkEngine(channelName: AgoraConfig.agoraAudioChannelName);
      // controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.typeOfUserKey) == "caller" ?
      // controller.createRoom(
      //     firstUserId: controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.currentUserIdKey) ?? "",
      //     secondUserId: controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.detailsProfileUserUniqueIdKey) ?? "",
      //     channelName: AgoraConfig.agoraAudioChannelName
      // )
      // //     : controller.createRoom(
      //     firstUserId: controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.detailsProfileUserUniqueIdKey) ?? "",
      //     secondUserId: controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.currentUserIdKey) ?? "",
      //     channelName: AgoraConfig.agoraAudioChannelName
      // );

    });
    super.initState();
  }

  @override
  void dispose() {
    Get.find<AudioCallController>().disposeAgora();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      mobileUI: AudioCallMobileView(
        channelId: channelID,
        userImage: userProfileImage,
      ),
      desktopUI: AudioCallWebView(
        channelId: channelID,
        userImage: userProfileImage,
      ),
    );
  }
}
