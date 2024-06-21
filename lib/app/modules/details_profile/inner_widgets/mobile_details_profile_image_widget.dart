import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/modules/details_profile/controllers/details_profile_controller.dart';

class MobileDetailsProfileImageWidget extends StatelessWidget {
  final int imageIndex;
  const MobileDetailsProfileImageWidget({required this.imageIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsProfileController>(
      builder: (controller) => controller.favoriteCheckingArray[imageIndex] == 1 ? GestureDetector(
        onDoubleTap: () => controller.removeFavoriteProfileImage(imageIndex, profileImageId: controller.profileImages[imageIndex].id ?? -1),
        child: CachedNetworkImage(
          imageUrl: "${ApiUrlContainer.baseUrl}${controller.profileImages[imageIndex].file}",
          imageBuilder: (context, imageProvider) => Container(
              height: Get.height, width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                  )
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12, top: 12),
                  child: Container(
                    height: 40, width: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppColors.colorWhite, shape: BoxShape.circle
                    ),
                    child: const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                  )
                ),
              )
          ),
        ),
      ) : GestureDetector(
        onDoubleTap: () => controller.makeFavoriteProfileImage(imageIndex, profileImageId: controller.profileImages[imageIndex].id ?? -1),
        child: CachedNetworkImage(
          imageUrl: "${ApiUrlContainer.baseUrl}${controller.profileImages[imageIndex].file}",
          imageBuilder: (context, imageProvider) => Container(
              height: Get.height, width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                  )
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12, top: 12),
                  child: Container(
                    height: 40, width: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppColors.colorWhite, shape: BoxShape.circle
                    ),
                    child: const Icon(Icons.favorite_border_rounded, color: Colors.redAccent, size: 20),
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}
