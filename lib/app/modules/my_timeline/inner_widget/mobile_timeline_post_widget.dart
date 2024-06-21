import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/date_convert_helper.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/my_timeline/controllers/my_timeline_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MobileTimelinePostWidget extends StatefulWidget {
  final int postIndex;
  const MobileTimelinePostWidget({
    required this.postIndex,
    super.key
  });

  @override
  State<MobileTimelinePostWidget> createState() => _MobileTimelinePostWidgetState();
}

class _MobileTimelinePostWidgetState extends State<MobileTimelinePostWidget> {
  // List<VideoPlayerController> videoControllers = [];
  // List<ChewieController?> cheweiControllers = [];
  // List<bool> isVideoPlay = [];
  //
  // @override
  // void initState() {
  //   final controller = Get.find<MyTimelineController>();
  //   for(var file in controller.timelineList[widget.postIndex].files!){
  //     if(file.extension == "mp4"){
  //       var videoPlayer = VideoPlayerController.networkUrl(
  //           Uri.parse("${ApiUrlContainer.baseUrl}${file.file.toString()}"));
  //
  //         // ..initialize().then((value) => setState(() {}));
  //       videoControllers.add(videoPlayer);
  //         // ..setLooping(true)
  //         // ..play()
  //
  //       cheweiControllers.add(ChewieController(videoPlayerController: videoPlayer));
  //       // for(var videoFile in videoControllers){
  //       //   cheweiControllers.add(ChewieController(
  //       //     videoPlayerController: videoFile,
  //       //     autoInitialize: true,
  //       //     autoPlay: false,
  //       //
  //       //   ));
  //       // }
  //       isVideoPlay.add(false);
  //       setState(() {});
  //     }else{
  //       //videoControllers.add(null);
  //       cheweiControllers.add(null);
  //       isVideoPlay.add(true);
  //       setState(() {});
  //     }
  //   }
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   for(var cheweiController in cheweiControllers){
  //     cheweiController?.pause();
  //     cheweiController?.dispose();
  //   }
  //   for(var videoController in videoControllers){
  //     videoController?.pause();
  //     videoController?.dispose();
  //   }
  //   print("----------------- dispose controller");
  //   super.dispose();
  // }

  List<CustomVideoPlayerController?> customVideoPlayerControllers = [];
  List<bool> isVideoPlay = [];

  @override
  void initState() {
    final controller = Get.find<MyTimelineController>();

    for(int i = 0; i < controller.timelineList.length; i++){
      controller.timelineList[i].files?.forEach((element) {
        if(element.extension == "mp4"){
          var videoPlayer = VideoPlayerController.networkUrl(
            Uri.parse("${ApiUrlContainer.baseUrl}${element.file.toString()}")
          )..initialize().then((value) => setState(() {}));

          if(mounted){
            if(videoPlayer.value.isInitialized){
              videoPlayer.addListener(() {
                setState(() {

                });
              });
            }
          }

          customVideoPlayerControllers.add(CustomVideoPlayerController(
              context: context,
              videoPlayerController: videoPlayer
          ));
          isVideoPlay.add(false);
          setState(() {});
        }else{
          customVideoPlayerControllers.add(null);
          isVideoPlay.add(true);
          setState(() {});
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    for(var videoController in customVideoPlayerControllers){
      videoController?.dispose();
    }
    print("----------------- dispose controller");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTimelineController>(
      builder: (controller) => Container(
        width: Get.width,
        padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          color: AppColors.colorWhite,
          border: Border(
            bottom: BorderSide(color: AppColors.colorGrayB, width: 1)
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // todo -> profile image and name section
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      controller.profileImages.isEmpty ? Container(
                        height: 40, width: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.colorRedB,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(AppImages.iluImage),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ) : Container(
                        height: 40, width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(controller.userProfileImage),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Gap(8),
                      Text(
                        controller.username,
                        style: AppTextStyle.appTextStyle(
                            textColor: AppColors.colorDarkA,
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: AppColors.colorWhite,
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 5, width: 75,
                                decoration: BoxDecoration(
                                  color: AppColors.colorDarkA.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15)
                                ),
                              ),
                            ),
                            const Gap(20),
                            // edit
                            GestureDetector(
                              onTap: (){
                                int editPostId = controller.timelineList[widget.postIndex].id ?? 0;
                                controller.repo.apiService.sharedPreferences.setInt(LocalStorageHelper.editPostIdKey, editPostId);
                                Get.back();
                                Get.toNamed(Routes.EDIT_POST);
                              },
                              child: Container(
                                width: Get.width,
                                alignment: Alignment.center,
                                padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                    color: AppColors.colorWhite,
                                    border: Border.all(color: AppColors.colorGrayB, width: 1),
                                    borderRadius: BorderRadius.circular(99)
                                ),
                                child: Text(
                                  "Edit",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkB,
                                      fontSize: 16, fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            ),
                            const Gap(12),
                            // delete
                            GestureDetector(
                              onTap: () {
                                Get.back();
                                showDialog(
                                    context: context,
                                    builder: (context) => CustomDialog(
                                      dialogChild: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Are you Sure that you want to delete this post?",
                                            textAlign: TextAlign.center,
                                            style: AppTextStyle.appTextStyle(
                                                textColor: AppColors.colorDarkA,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const Gap(24),
                                          // delete button
                                          GestureDetector(
                                            onTap: (){
                                              controller.postDelete(postId: controller.timelineList[widget.postIndex].id ?? -1);
                                            },
                                            child: Container(
                                                width: Get.width,
                                                padding: const EdgeInsetsDirectional.symmetric(
                                                    horizontal: 16, vertical: 16),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: const GradientBoxBorder(gradient: AppColors.redGradient),
                                                    borderRadius: BorderRadius.circular(99)
                                                ),
                                                child: GradientText(
                                                  "Delete",
                                                  colors: const [Color(0xffFF597B),Color(0xffF5827A)],
                                                  style: AppTextStyle.appTextStyle(
                                                      fontSize: 16, fontWeight: FontWeight.w600
                                                  ),
                                                )
                                            ),
                                          ),
                                          const Gap(12),
                                          CustomOutlineButton(onPressed: () => Get.back(), buttonText: "Close")
                                        ],
                                      ),
                                    )
                                );
                              },
                              child: Container(
                                width: Get.width,
                                alignment: Alignment.center,
                                padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                    color: AppColors.colorWhite,
                                    border: Border.all(color: AppColors.colorGrayB, width: 1),
                                    borderRadius: BorderRadius.circular(99)
                                ),
                                child: Text(
                                  "Delete",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkB,
                                      fontSize: 16, fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                    iconSize: 20,
                    icon: const Icon(Icons.more_horiz_rounded, color: AppColors.colorDarkA, size: 20),
                  )
                ],
              ),
            ),
            const Gap(12),
            controller.timelineList[widget.postIndex].files!.isNotEmpty ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CarouselSlider(
                        carouselController: controller.ccList[widget.postIndex],
                        items: List.generate(controller.timelineList[widget.postIndex].files!.length, (fileIndex){
                          if(controller.timelineList[widget.postIndex].files![fileIndex].extension == "mp4"){
                            return customVideoPlayerControllers[fileIndex] == null ? const SizedBox() : SizedBox(
                              width: Get.width, height: Get.height,
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  CustomVideoPlayer(
                                    customVideoPlayerController: customVideoPlayerControllers[fileIndex]!,
                                  ),
                                  // Align(
                                  //   alignment: Alignment.center,
                                  //   child: IconButton(
                                  //     onPressed: (){
                                  //       togglePlayPause(fileIndex);
                                  //     },
                                  //     icon: isVideoPlay[fileIndex] ? const Icon(
                                  //       Icons.pause_circle_outline_outlined,
                                  //       color: AppColors.colorLightWhite,
                                  //       size: 48,
                                  //     ) : const Icon(
                                  //       Icons.play_circle_outline_outlined,
                                  //       color: AppColors.colorLightWhite,
                                  //       size: 48,
                                  //     ),
                                  //     iconSize: 96,
                                  //   ),
                                  // )
                                ],
                              )
                            );
                          }else{
                            return Container(
                              height: Get.height, width: Get.width,
                              decoration: BoxDecoration(
                                  color: AppColors.colorRedB,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${ApiUrlContainer.baseUrl}${controller.timelineList[widget.postIndex].files![fileIndex].file.toString()}"
                                    ),
                                    fit: BoxFit.contain,

                                  )
                              ),
                            );
                          }
                        }),
                        options: CarouselOptions(
                            height: 360,
                            viewportFraction: 1,
                            scrollPhysics: controller.timelineList[widget.postIndex].files!.length == 1 ? const NeverScrollableScrollPhysics() : null,
                            autoPlay: false,
                            onPageChanged: (val, _) {
                              controller.changeTimelinePage(val, widget.postIndex);
                            }
                        ),
                      ),

                      // todo -> dots
                      controller.timelineList[widget.postIndex].files!.length == 1 ? const SizedBox() : Positioned.fill(
                        bottom: 20,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(controller.timelineList[widget.postIndex].files!.length, (postIndex) => postIndex == controller.timelineIndex ? Container(
                              height: 12, width: 12,
                              margin: const EdgeInsetsDirectional.only(end: 12),
                              decoration: const BoxDecoration(gradient: AppColors.primaryGradient, shape: BoxShape.circle),
                            ) :  Container(
                              height: 6, width: 6,
                              margin: const EdgeInsetsDirectional.only(end: 12),
                              decoration: const BoxDecoration(color: AppColors.colorWhite, shape: BoxShape.circle),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(12),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.timelineList[widget.postIndex].caption == null ? const SizedBox() : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.timelineList[widget.postIndex].caption ?? "",
                            style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          const Gap(12),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  controller.formattedDate(controller.timelineList[widget.postIndex].updatedAt ?? ""),
                                  style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkB,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12
                                  ),
                                ),
                                const Gap(4),
                                Container(
                                  height: 4, width: 4,
                                  decoration: const BoxDecoration(
                                    color: AppColors.colorDarkB,
                                    shape: BoxShape.circle
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  DateConvertHelper.isoStringToLocalFormattedDateOnly(controller.timelineList[widget.postIndex].updatedAt ?? ""),
                                  style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkB,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                            controller.timelineList[widget.postIndex].liked == 0 ? const SizedBox() : InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () async{
                                await controller.loadPostLikedUsersData(
                                  controller.timelineList[widget.postIndex].liked ?? -1,
                                  postId: controller.timelineList[widget.postIndex].id ?? -1
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${controller.timelineList[widget.postIndex].liked ?? 0} Likes",
                                    style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkA,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
              ],
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.timelineList[widget.postIndex].caption ?? "",
                            style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          const Gap(12),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                controller.formattedDate(controller.timelineList[widget.postIndex].updatedAt ?? ""),
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkB,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12
                                ),
                              ),
                              const Gap(4),
                              Container(
                                height: 4, width: 4,
                                decoration: const BoxDecoration(
                                    color: AppColors.colorDarkB,
                                    shape: BoxShape.circle
                                ),
                              ),
                              const Gap(4),
                              Text(
                                DateConvertHelper.isoStringToLocalFormattedDateOnly(controller.timelineList[widget.postIndex].createdAt ?? ""),
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkB,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12
                                ),
                              ),
                            ],
                          ),
                          controller.timelineList[widget.postIndex].liked == 0 ? const SizedBox() : InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              await controller.loadPostLikedUsersData(
                                controller.timelineList[widget.postIndex].liked ?? -1,
                                postId: controller.timelineList[widget.postIndex].id ?? -1
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${controller.timelineList[widget.postIndex].liked ?? 0} Likes",
                                  style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkA,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
