import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/block_list/controllers/block_list_controller.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class BlockListMobileView extends StatelessWidget {
  const BlockListMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<BlockListController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.back(),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "Block List",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: controller.isLoading ? const Center(
            child: CircularProgressIndicator(color: AppColors.colorDarkA),
          ) : controller.blockList.isEmpty ? Center(
            child: Text(
              "No Blocked Users Found",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ) : SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
            child: GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 225),
              children: List.generate(
                  controller.blockList.length,
                      (index) => GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) => CustomDialog(
                                dialogChild: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Are you Sure that you want to Unblock this user?",
                                      style: AppTextStyle.appTextStyle(
                                          textColor: AppColors.colorDarkA,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    const Gap(24),
                                    // delete button
                                    GestureDetector(
                                      onTap: () => controller.unblockUser(id: controller.blockList[index].id ?? -1),
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
                                            "Unblock",
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
                          decoration: BoxDecoration(
                              color: AppColors.colorRedB,
                              borderRadius: BorderRadius.circular(15),
                              image: controller.blockList[index].profileImage == null ? const DecorationImage(
                                  image: AssetImage(AppImages.iluImage),
                                  fit: BoxFit.contain
                              ) : DecorationImage(
                                  image: NetworkImage("${ApiUrlContainer.baseUrl}${controller.blockList[index].profileImage?.file}"),
                                  fit: BoxFit.contain
                              )
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Opacity(
                                opacity: 0.2,
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: AppColors.colorDarkA,
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.colorRedB,
                                    borderRadius: BorderRadius.circular(99)
                                  ),
                                  child: GradientText(
                                    "Unblock",
                                    colors: const [Color(0xffff597b), Color(0xfff6827a)],
                                    style: AppTextStyle.appTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                )
                              ),
                              Positioned(
                                left: 12, right: 12,
                                bottom: 12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${controller.blockList[index].firstName} ${controller.blockList[index].lastName}",
                                      style: AppTextStyle.appTextStyle(
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const Gap(4),
                                    Row(
                                      children: [
                                        Text(
                                            "ID ${controller.blockList[index].uniqueId}",
                                            style: AppTextStyle.appTextStyle(
                                                textColor: AppColors.colorWhite,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400
                                            )
                                        ),
                                        const Gap(8),
                                        Container(
                                          height: 10,
                                          width: 1,
                                          color: AppColors.colorWhite,
                                        ),
                                        const Gap(8),
                                        Text(
                                            "${controller.blockList[index].age} y",
                                            style: AppTextStyle.appTextStyle(
                                                textColor: AppColors.colorWhite,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400
                                            )
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
              ),
            )
          ),
        )
      ),
    );
  }
}
