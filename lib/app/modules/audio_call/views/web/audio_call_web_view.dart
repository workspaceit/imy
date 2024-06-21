import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/audio_call/controllers/audio_call_controller.dart';

class AudioCallWebView extends StatelessWidget {
  final String channelId;
  final String userImage;
  const AudioCallWebView({
    required this.channelId,
    required this.userImage,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<AudioCallController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorLightWhite,
          /// ------------------- appbar ------------------
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorLightWhite,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(AppIcons.arrowBack),
                alignment: Alignment.center
            ),
            titleSpacing: 0,
            title: Text(
              controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.detailsProfileUsernameKey) ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontWeight: FontWeight.w600,
                  fontSize: 14
              ),
            ),
          ),
          /// ------------------- body --------------------
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// -------------- user image -----------------
                userImage.isEmpty ? Container(
                  height: 100, width: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(AppImages.iluImage),
                      fit: BoxFit.contain
                    )
                  ),
                ) : Container(
                  height: 100, width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(userImage),
                      fit: BoxFit.contain
                    ),
                    shape: BoxShape.circle
                  ),
                ),
                const Gap(12),
                /// ------------------ user name --------------------
                Text(
                  controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.detailsProfileUsernameKey) ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.appTextStyle(
                      textColor: AppColors.colorDarkA,
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                  ),
                ),
                const Gap(4),
                /// ------------------- call status -------------------
                SizedBox(
                  height: 40,
                  child:Center(
                    child: status(context, controller)
                  )
                ),
              ],
            ),
          ),

          /// --------------- bottom navigation ------------------------
          bottomNavigationBar: Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              /// ---------------- call cancel button -----------------
              child: InkWell(
                hoverColor: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(100),
                onTap: () => controller.leave(),
                child: Container(
                  height: 44, width: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle
                  ),
                  child: const Icon(
                    Icons.call_end,
                    color: AppColors.colorWhite,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  /// ------------- this method is used to detect user status ------------------
  Widget status(BuildContext context, AudioCallController controller) {
    String statusText;

    if (!controller.localUserJoined) {
      statusText = 'Join a channel';
    } else if (controller.remoteUserId == null){
      statusText = 'Waiting for a remote user to join...';
    }
    else{
      statusText = 'Connected to remote user, uid:${controller.remoteUserId}';
    }

    return Text(
      statusText,
      textAlign: TextAlign.center,
      style: AppTextStyle.appTextStyle(
        textColor: AppColors.colorDarkA.withOpacity(0.5),
        fontSize: 14,
        fontWeight: FontWeight.w400
      ),
    );
  }
}
