import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/edit_post/controllers/edit_post_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/bottom_nav/auth_bottom_nav.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class EditPostMobileUiView extends StatelessWidget {
  const EditPostMobileUiView({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: GetBuilder<EditPostController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          /// ---------------- appbar -------------------------------
          appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.colorWhite,
              leading: IconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Get.toNamed(Routes.MY_TIMELINE);
                  },
                  alignment: Alignment.center,
                  icon: SvgPicture.asset(AppIcons.arrowBack),
                  iconSize: 24),
              title: Text(
                "Edit Post",
                textAlign: TextAlign.center,
                style: AppTextStyle.appTextStyle(
                    textColor: AppColors.colorDarkA,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
                  child: controller.isUpdate ? const SizedBox(
                    height: 16, width: 16,
                    child: CircularProgressIndicator(
                      color: AppColors.colorDarkA, strokeWidth: 2,
                    ),
                  ) : TextButton(
                      onPressed: () {
                        controller.updatePostInMobile();
                      },
                      child: controller.isSubmit ? const SizedBox(
                        height: 16, width: 16,
                        child: CircularProgressIndicator(color: AppColors.colorDarkA, strokeWidth: 2),
                      ) : GradientText(
                          "Save",
                          style: AppTextStyle.appTextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                          colors: const [
                            Color(0xffFFD000),
                            Color(0xffF80261),
                            Color(0xff7017FF)
                          ]
                      )
                  ),
                )
              ],
            ),
          body: controller.isLoading ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.colorDarkA,
            ),
          ) : SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    /// ------------------ user image section ---------------------------
                    controller.profileImages.isEmpty ? Container(
                      height: 48, width: 48,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.iluImage),
                            fit: BoxFit.scaleDown,
                          ),
                          shape: BoxShape.circle
                      ),
                    ) : CachedNetworkImage(
                      imageUrl: controller.userProfileImage,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 48, width: 48,
                        decoration: BoxDecoration(
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
                    hintText: controller.postController.text.isEmpty ? "What's on your mind?" : null,
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
                ),
                const Gap(16),
                controller.imageFileList.isEmpty && controller.fileList.isEmpty ? const SizedBox() : ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const Gap(12),
                  itemCount: 5,
                  itemBuilder: (context, index){
                    if (controller.fileList.isEmpty){
                      if(index < controller.imageFileList.length){
                        return Container(
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                          height: 400, width: Get.width,
                          decoration: BoxDecoration(
                              color: AppColors.colorLightWhite,
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                  image: FileImage(File(controller.imageFileList[index].path)),
                                  fit: BoxFit.contain
                              )
                          ),
                        );
                      }else{
                        return const SizedBox();
                      }
                    } else{
                      if(index < controller.fileList.length){
                        return CachedNetworkImage(
                            imageUrl: "${ApiUrlContainer.baseUrl}${controller.fileList[index].file}",
                            imageBuilder: (context, imageProvider) => Container(
                              padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                              height: 400, width: Get.width,
                              decoration: BoxDecoration(
                                  color: AppColors.colorLightWhite,
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.contain)
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  hoverColor: AppColors.colorLightWhite,
                                  onTap: () => controller.deleteProfileImage(index),                                  child: Container(
                                    height: 40, width: 40,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: AppColors.colorWhite,
                                        shape: BoxShape.circle
                                    ),
                                    child: const Icon(Icons.clear, color: AppColors.colorDarkA, size: 20),
                                  ),
                                ),
                              ),
                            )
                        );
                      }else{
                        int localImageIndex = index - controller.fileList.length;
                        if(localImageIndex < controller.imageFileList.length){
                          return Container(
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                            height: 400, width: Get.width,
                            decoration: BoxDecoration(
                              color: AppColors.colorLightWhite,
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: FileImage(File(controller.imageFileList[localImageIndex].path)),
                                fit: BoxFit.contain
                              )
                            ),
                          );
                        }else{
                          return const SizedBox();
                        }
                      }
                    }
                  },
                )
              ],
            ),
          ),
          bottomNavigationBar: AuthBottomNav(
            bottomNavChild: GestureDetector(
              onTap: () {
                controller.pickImage();
              },
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
