import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/create_post/controllers/create_post_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CreatePostWebUiView extends StatelessWidget {
  const CreatePostWebUiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<CreatePostController>(
        builder: (controller) => Scaffold(
                backgroundColor: AppColors.colorWhite,
                /// ---------------- appbar -------------------------------
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
                    controller.selectedImages.isNotEmpty || controller.showPostText ? Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
                      child: TextButton(
                        onPressed: () {
                          controller.createWebPost();
                        },
                        child: controller.isSubmit ? const SizedBox(
                          height: 16, width: 16,
                          child: CircularProgressIndicator(color: AppColors.colorDarkA, strokeWidth: 2),
                        ) : GradientText(
                          "Post",
                          style: AppTextStyle.appTextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
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
                /// ---------------- body ---------------------------------
                body: controller.isLoading ? const Center(
                  child: CircularProgressIndicator(color: AppColors.colorDarkA),
                ) : SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              /// ------------------ user image section ---------------------------
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
                              ): CachedNetworkImage(
                                imageUrl: controller.userProfileImage,
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 48, width: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.colorRedB,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                    shape: BoxShape.circle
                                  ),
                                ),
                              ),
                              const Gap(12),
                              /// ------------------------- username section -------------------------
                              Expanded(
                                child: Text(
                                  controller.username,
                                  style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkA,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          const Gap(24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ------------------ post caption field -------------------------
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
                              /// ------------------ pick image section -------------------------
                              controller.selectedImages.isEmpty ? const SizedBox() : Column(
                                children: [
                                  const Gap(24),
                                  controller.selectedImages.isNotEmpty ? Column(
                                    children: [
                                      // Show the first image
                                      Container(
                                        height: 400,
                                        width: Get.width,
                                        margin: const EdgeInsetsDirectional.only(bottom: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorRedB,
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: MemoryImage(controller
                                                .selectedImages[0]!),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),

                                      // Show the second and third images, or the last image with overlay
                                      Row(
                                        children: [
                                          if(controller.selectedImages.length > 1)
                                            Expanded(
                                              child: Container(
                                                height: 400,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: AppColors.colorRedB,
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  image: DecorationImage(
                                                    image: MemoryImage(
                                                        controller.selectedImages[1]!),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          const Gap(8),
                                          if (controller.selectedImages.length > 2)
                                            Expanded(
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    height: 400,
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.colorRedB,
                                                      borderRadius: BorderRadius.circular(20),
                                                      image: DecorationImage(
                                                        image: MemoryImage(controller.selectedImages[2]!),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: controller.selectedImages.length > 3,
                                                    child: Align(
                                                        alignment: Alignment.center,
                                                        child: Container(
                                                          height: 400, width: Get.width,
                                                          decoration: BoxDecoration(
                                                              color: AppColors.colorDarkA.withOpacity(0.6),
                                                              borderRadius: BorderRadius.circular(20)
                                                          ),
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            '+ ${controller.selectedImages.length - 3}',
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
                              ),
                              const Gap(20)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                /// ----------------------- image picker button ---------------------
                bottomNavigationBar: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 160),
                  child: Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 40),
                    color: AppColors.colorWhite,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(99),
                      hoverColor: AppColors.colorWhite,
                      onTap: (){
                        controller.pickMultipleImagesForWeb();
                      },
                      child: Container(
                        width: 600,
                        alignment: Alignment.center,
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
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
                )
            ),
      ),
    );
  }
}