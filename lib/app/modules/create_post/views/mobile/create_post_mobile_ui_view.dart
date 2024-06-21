import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/create_post/controllers/create_post_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/bottom_nav/auth_bottom_nav.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';

class CreatePostMobileUiView extends StatelessWidget {
  const CreatePostMobileUiView({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: GetBuilder<CreatePostController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.clearData();
                  Get.toNamed(Routes.HOME);
                },
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "Create Post",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              controller.imageFileList.isNotEmpty || controller.showPostText ? Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                child: TextButton(
                    onPressed: (){
                      controller.createPost();
                    },
                    child: controller.isSubmit ? const SizedBox(
                      height: 16, width: 16,
                      child: CircularProgressIndicator(color: AppColors.colorDarkA, strokeWidth: 2),
                    ) : GradientText(
                        "Post",
                        style: AppTextStyle.appTextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500
                        ),
                        colors: const [
                          Color(0xffFFD000),
                          Color(0xffF80261),
                          Color(0xff7017FF)
                        ]
                    )
                ),
              ) : const SizedBox()
            ],
          ),
          body:controller.isLoading ? const Center(
            child: CircularProgressIndicator(color: AppColors.colorDarkA),
          ) :  SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// -------------------- user info section
                Row(
                  children: [
                    controller.profileImages.isEmpty ? Container(
                      height: 48, width: 48,
                      decoration: const BoxDecoration(
                        color: AppColors.colorRedB,
                          image: DecorationImage(
                              image: AssetImage(AppImages.iluImage),
                              fit: BoxFit.scaleDown,
                          ),
                          shape: BoxShape.circle
                      ),
                    ) : Container(
                      height: 48, width: 48,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(controller.userProfileImage),
                          fit: BoxFit.contain,
                        ),
                        shape: BoxShape.circle
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Text(
                        controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.userNameKey) ?? "",
                        style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                const Gap(24),
                /// -------------------- caption field section
                TextField(
                  cursorColor: AppColors.colorDarkA,
                  cursorHeight: 30,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  controller: controller.postController,
                  style: AppTextStyle.appTextStyle(
                    textColor: AppColors.colorDarkA,
                    fontSize: 14,
                    fontWeight: FontWeight.normal
                  ),
                  decoration: InputDecoration(
                    hintText: "What's on your mind?",
                    hintStyle: AppTextStyle.appTextStyle(
                      textColor: AppColors.colorDarkB,
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                    ),
                    filled: true,
                    fillColor: AppColors.colorWhite,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                  onChanged: (value) => controller.changeValue(value),
                ),
                controller.imageFileList.isEmpty ? const SizedBox() : Column(
                  children: [
                    const Gap(24),
                    controller.imageFileList.isNotEmpty ? Column(
                      children: [
                        /// ------------------------- Show the first image or video
                        controller.fileExtension == ".mp4" ? Padding(
                          padding: const EdgeInsetsDirectional.only(bottom: 8),
                          child: controller.videoControllers![0].value.isInitialized ? SizedBox(
                            height: 320, width: Get.width,
                            child: VideoPlayer(controller.videoControllers![0])
                          ) : const SizedBox(),
                        ) : Container(
                          height: 320,
                          width: Get.width,
                          margin: const EdgeInsetsDirectional.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: AppColors.colorGrayB,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: FileImage(File(controller.imageFileList[0].path)),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        /// -------------------- Show the second and third images, or the last image with overlay
                        Row(
                          children: [
                            if(controller.imageFileList.length > 1)
                              Expanded(
                                child: controller.fileExtension == ".mp4" ? Padding(
                                  padding: const EdgeInsetsDirectional.only(bottom: 8),
                                  child: controller.videoControllers![1].value.isInitialized ? SizedBox(
                                      height: 158, width: Get.width,
                                      child: VideoPlayer(controller.videoControllers![1])
                                  ) : const SizedBox(),
                                )  :  Container(
                                  height: 158,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: AppColors.colorGrayB,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: FileImage(File(controller.imageFileList[1].path)),
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            const Gap(8),
                            if (controller.imageFileList.length > 2)
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    controller.fileExtension == ".mp4" ? Padding(
                                      padding: const EdgeInsetsDirectional.only(bottom: 8),
                                      child: controller.videoControllers![2].value.isInitialized ? SizedBox(
                                          height: 158, width: Get.width,
                                          child: VideoPlayer(controller.videoControllers![2])
                                      ) : const SizedBox(),
                                    ) : Container(
                                      height: 158,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: AppColors.colorGrayB,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: FileImage(File(controller.imageFileList[2].path)),
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: controller.imageFileList.length > 3,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: controller.fileExtension == ".mp4" ? SizedBox(
                                            height: 158, width: Get.width,
                                            child: Center(
                                              child: Text(
                                                '+ ${controller.imageFileList.length - 3}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                            ),
                                          ) :  Container(
                                            height: 158, width: Get.width,
                                            decoration: BoxDecoration(
                                                color: AppColors.colorDarkA.withOpacity(0.6),
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '+ ${controller.imageFileList.length - 3}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ) : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
          bottomNavigationBar: AuthBottomNav(
            bottomNavChild: GestureDetector(
              onTap: () => controller.pickImage(),
              child: Container(
                width: Get.width,
                padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: AppColors.colorWhite,
                    border: Border.all(
                        color: AppColors.colorGrayB,
                        width: 1
                    )
                ),
                child: SvgPicture.asset(AppIcons.gallery),
              ),
            ),
          )
        ),
      ),
    );
  }
}
