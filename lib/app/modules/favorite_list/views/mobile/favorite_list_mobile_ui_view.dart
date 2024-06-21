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
import 'package:ilu/app/modules/favorite_list/controllers/favorite_list_controller.dart';

class FavoriteListMobileUiView extends StatelessWidget {
  const FavoriteListMobileUiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<FavoriteListController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.back(),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "Favorite List",
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
          ) : controller.favoriteList.isEmpty ? Center(
            child: Text(
              "No Favorite Users Found",
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
                mainAxisExtent: 225
              ),
              children: List.generate(
                controller.favoriteList.length,
                (index) => GestureDetector(
                  onTap: () => controller.deleteFavoriteUser(id: controller.favoriteList[index].id ?? -1),
                  child: controller.favoriteList[index].profileImage == null ? Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColors.colorRedB,
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: AssetImage(AppImages.iluImage),
                          fit: BoxFit.contain
                      )
                    ),
                    child: Stack(
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
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 40, width: 40,
                            margin: const EdgeInsetsDirectional.only(top: 12, end: 12),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: AppColors.colorLightWhite,
                                shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                          ),
                        ),
                        Positioned(
                          left: 12, right: 12,
                          bottom: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${controller.favoriteList[index].firstName} ${controller.favoriteList[index].lastName}",
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Gap(4),
                              Row(
                                children: [
                                  Text(
                                      "ID ${controller.favoriteList[index].uniqueId}",
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
                                      "${controller.favoriteList[index].age} y",
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
                  ) : CachedNetworkImage(
                    imageUrl: "${ApiUrlContainer.baseUrl}${controller.favoriteList[index].profileImage?.file}",
                    imageBuilder: (context, imageProvider) => Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: AppColors.colorRedB,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: imageProvider,
                            fit: BoxFit.contain
                        )
                      ),
                      child: Stack(
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
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 40, width: 40,
                              margin: const EdgeInsetsDirectional.only(top: 12, end: 12),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: AppColors.colorLightWhite,
                                  shape: BoxShape.circle
                              ),
                              child: const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                            ),
                          ),
                          Positioned(
                            left: 12, right: 12,
                            bottom: 12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${controller.favoriteList[index].firstName} ${controller.favoriteList[index].lastName}",
                                  style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorWhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Gap(4),
                                Row(
                                  children: [
                                    Text(
                                        "ID ${controller.favoriteList[index].uniqueId}",
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
                                      "${controller.favoriteList[index].age} y",
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
                  ),
                )
              ),
            ),
          ),
        );
      }),
    );
  }
}
