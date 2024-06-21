import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/agora_settings.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/data/call/audio_call_repo.dart';
import 'package:ilu/app/models/call_history/create_call_response_model.dart';
import 'package:ilu/app/models/default_setting/default_setting_response_model.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioCallController extends GetxController {
  AudioCallRepo repo;
  AudioCallController({required this.repo});

  int localUserId = 0; // uid of the local user

  int? remoteUserId; // uid of the remote user
  bool localUserJoined = false;
  late RtcEngine engine; // Indicates if the local user has joined the channel

  int rechargeBalance = 0;
  int rewardPoints = 0;
  String? callUser;

  Future<void> getUserData() async{
    ApiResponseModel responseModel = await repo.getUserProfile();

    if(responseModel.statusCode == 200){
      ProfileResponseModel profileResponseModel = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      rechargeBalance = profileResponseModel.iluPoints ?? 0;
      if(rechargeBalance < 0){
        rechargeBalance = 0;
      }
      rewardPoints = profileResponseModel.rewardPoints ?? 0;
      if(rewardPoints < 0){
        rewardPoints = 0;
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }
    await getDefaultSetting();
    update();
  }

  /// ---------------- this method is used to set up agora voice sdk engine
  Future<void> setUpAgoraVoiceSdkEngine({required String channelName}) async{
    // retrieve microphone permission and speaker permission
    await [Permission.microphone].request();

    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: AgoraConfig.agoraAppId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    await engine.enableAudio();
    joinCall(channelName: channelName);

    engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed){
            print("------- join channel success");
            print('------- local user id: ${connection.localUid}');
            localUserJoined = true;
            update();
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            print("--------- remote user joined the channel");
            remoteUserId = remoteUid;
            update();

            print("--------- remote user id: $remoteUserId");

            joinCallTime = DateTime.now();
            String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(joinCallTime!);
            startTime = formattedDate;
            update();
          },
          onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
            leave();
          },
          onLeaveChannel: (RtcConnection connection, RtcStats stats){
            print("------------- on channel leave");
          }
        )
    );
  }

  /// -------------- declare variable
  DateTime? joinCallTime;
  String startTime = "";
  /// ------------------------ this method is used to create call
  void joinCall({required String channelName}) async {
    /// Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(

      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await engine.joinChannel(
      token:  AgoraConfig.agoraToken,
      channelId:  AgoraConfig.agoraAudioChannelName,
      options: options,
      uid: 0,//localUserId,
    );

    // joinCallTime = DateTime.now();
    // String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(joinCallTime!);
    // startTime = formattedDate;
    // update();
  }

  /// ----------------- this method is used to leave call
  DateTime? leaveCallTime;
  String endTime = "";
  Duration? callDuration;
  
  void leave() async {
    if(localUserJoined == true){
      await createCall();
    }
    engine.leaveChannel();
    Get.offAllNamed(Routes.HOME);
  }

  /// -----------------------
  disposeAgora() async{
    await engine.leaveChannel();
    await engine.release();
  }

  /// ---------------- this method is used to default setting
  int amountDeductionPerCall = 0;
  int amountRewardPerCall = 0;
  List<DefaultSettingResponseModel> settings = [];

  Future<void> getDefaultSetting() async{
    ApiResponseModel responseModel = await repo.getDefaultSettingData();
    if(responseModel.statusCode == 200){
      List<dynamic> tempList = jsonDecode(responseModel.responseJson);
      if(tempList.isNotEmpty){
        settings = tempList.map((data) => DefaultSettingResponseModel.fromJson(data)).toList();
      }

      for(var settingData in settings){
        if(settingData.key == "amount_deduction_per_call"){
          amountDeductionPerCall = int.tryParse("${settingData.value}") ?? 0;
          print("------------ amount deduction per call: $amountDeductionPerCall");
        }else if(settingData.key == "amount_reward_per_call"){
          amountRewardPerCall = int.tryParse("${settingData.value}") ?? 0;
          print("------------ amount reward per call: $amountRewardPerCall");
        }
      }
    }else if(responseModel.statusCode == 400){

    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{

    }
  }

  /// ---------------- this method is used to create call
  Future<void> createCall({int? idRemoteUser, bool? joinedLocalUser}) async{
    leaveCallTime = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(leaveCallTime!);
    endTime = formattedDate;
    callDuration = leaveCallTime?.difference(joinCallTime!);
    update();

    ApiResponseModel responseModel = await repo.createCall(
        callDuration: "${callDuration?.inSeconds} seconds",
        pointSpent: (callDuration?.inMinutes ?? 0) * amountDeductionPerCall,
        pointGained: amountRewardPerCall,
        startTime: startTime,
        endTime: endTime,
        receiverId: repo.apiService.sharedPreferences.getInt(LocalStorageHelper.detailsProfileUserIdKey) ?? 0
    );

    if(responseModel.statusCode == 201){
      CreateCallResponseModel model = CreateCallResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (_) => CustomDialog(
            width: 425,
            dialogChild: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Call Summary",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.appTextStyle(
                        textColor: AppColors.colorDarkA,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  const Gap(12),
                  Text(
                    "You have completed Audio Calling\nfor ${callDuration?.inMinutes} minutes."
                        "\nBalance Spent ${(callDuration?.inMinutes ?? 0) * 2}.\nYour Available Recharge Balance ${rechargeBalance - (callDuration?.inMinutes ?? 0 * 2)}",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.appTextStyle(
                        textColor: AppColors.colorDarkA.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                    ),
                  ),
                  const Gap(20),
                  CustomButton(
                      onPressed: (){
                        Get.back();
                        kIsWeb ? showDialog(
                            context: Get.context!,
                            builder: (_) => CustomDialog(
                              width: 400,
                              dialogChild: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Recharge Balance",
                                    style: AppTextStyle.appTextStyle(
                                        textColor: AppColors.colorDarkA,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  const Gap(20),
                                  CustomButton(
                                      onPressed: (){
                                        Get.back();
                                        Get.toNamed(Routes.RECHARGE_DIRECTLY);
                                      },
                                      buttonText: "Recharge Directly"
                                  ),
                                  const Gap(12),
                                  CustomButton(
                                      onPressed: (){
                                        Get.back();
                                        Get.toNamed(Routes.RECHARGE_FROM_REWARD_BALANCE);
                                      },
                                      buttonText: "Recharge From Reward Balance"
                                  ),
                                ],
                              ),
                            )) : showModalBottomSheet(
                            context: Get.context!,
                            backgroundColor: AppColors.colorWhite,
                            constraints: const BoxConstraints(maxHeight: 250),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                            ),
                            builder: (_) => Container(
                              width: Get.width,
                              padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
                              decoration: BoxDecoration(
                                  color: AppColors.colorWhite,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 5,
                                      width: 75,
                                      decoration: BoxDecoration(
                                          color: AppColors.colorDarkA.withOpacity(0.2),
                                          borderRadius:
                                          BorderRadius.circular(12)
                                      ),
                                    ),
                                  ),
                                  const Gap(20),
                                  Text(
                                    "Recharge Balance",
                                    style: AppTextStyle.appTextStyle(
                                        textColor: AppColors.colorDarkA,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  const Gap(20),
                                  CustomButton(
                                      onPressed: (){
                                        Get.back();
                                        Get.toNamed(Routes.RECHARGE_DIRECTLY);
                                      },
                                      buttonText: "Recharge Directly"
                                  ),
                                  const Gap(12),
                                  CustomButton(
                                      onPressed: (){
                                        Get.back();
                                        Get.toNamed(Routes.RECHARGE_FROM_REWARD_BALANCE);
                                      },
                                      buttonText: "Recharge From Reward Balance"
                                  ),
                                ],
                              ),
                            )
                        );
                      },
                      buttonText: "Recharge Balance"
                  ),
                  const Gap(12),
                  CustomOutlineButton(
                      onPressed: (){
                        Get.back();
                        Get.offAllNamed(Routes.HOME);
                      },
                      buttonText: "Close"
                  )
                ],
              ),
            ),
          )
      );
    }else if(responseModel.statusCode == 400){

    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{

    }
  }
}
