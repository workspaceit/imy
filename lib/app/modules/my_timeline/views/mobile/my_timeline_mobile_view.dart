import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/date_convert_helper.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/my_timeline/controllers/my_timeline_controller.dart';
import 'package:ilu/app/modules/my_timeline/inner_widget/mobile_timeline_post_widget.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';

class MyTimeLineMobileView extends StatefulWidget {

  const MyTimeLineMobileView({super.key});

  @override
  State<MyTimeLineMobileView> createState() => _MyTimeLineMobileViewState();
}

class _MyTimeLineMobileViewState extends State<MyTimeLineMobileView> {
  // List<VideoPlayerController?> videoControllers = [];
  // List<bool> isVideoPlay = [];
  //
  // @override
  // void initState() {
  //   final controller = Get.find<MyTimelineController>();
  //
  //   for(int i = 0; i < controller.timelineList.length; i++){
  //     controller.timelineList[i].files?.forEach((element) {
  //       if(element.extension == "mp4"){
  //         videoControllers.add(VideoPlayerController.networkUrl(
  //           Uri.parse("${ApiUrlContainer.baseUrl}${element.file.toString()}")
  //         )..initialize().then((value) => setState(() {})));
  //         isVideoPlay.add(false);
  //         setState(() {});
  //       }else{
  //         videoControllers.add(null);
  //         isVideoPlay.add(true);
  //         setState(() {});
  //       }
  //     });
  //   }
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   for(var videoController in videoControllers){
  //     videoController?.pause();
  //     videoController?.dispose();
  //   }
  //   print("----------------- dispose controller");
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: GetBuilder<MyTimelineController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.toNamed(Routes.PROFILE),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "My Timeline",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: controller.isLoading ? const Center(
              child: CircularProgressIndicator(color: AppColors.colorDarkA)
          ) :  SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
            child: Column(
              children: [
                // todo -> post section
                InkWell(
                  onTap: () => Get.toNamed(Routes.CREATE_POST),
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 24),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.colorGrayB, width: 2),
                        bottom: BorderSide(color: AppColors.colorGrayB, width: 2),
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              controller.profileImages.isEmpty ? Container(
                                height: 48, width: 48,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.iluImage),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ) : Container(
                                height: 48, width: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.colorRedB,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(controller.userProfileImage),
                                      fit: BoxFit.contain,

                                  ),
                                ),
                              ),
                              const Gap(12),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  "What's on your mind?",
                                  style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkB,
                                    fontSize: 14, fontWeight: FontWeight.w400
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Gap(12),
                        SvgPicture.asset(AppIcons.gallery),
                      ],
                    ),
                  ),
                ),

                // todo -> timeline
                controller.timelineList.isEmpty ? Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: Get.height * 0.4),
                  child: Text(
                    "No Post Available",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ): Column(
                  children: List.generate(controller.timelineList.length, (postIndex) {
                    return MobileTimelinePostWidget(postIndex: postIndex);
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void togglePlayPause(int fileIndex) {
  //   setState(() {
  //     if (videoControllers[fileIndex]!.value.isPlaying) {
  //       videoControllers[fileIndex]!.pause();
  //       isVideoPlay[fileIndex] = false;
  //     } else {
  //       videoControllers[fileIndex]!.play();
  //       isVideoPlay[fileIndex] = true;
  //     }
  //   });
  // }
}
