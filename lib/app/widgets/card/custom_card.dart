import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';

class CustomCard extends StatelessWidget {
  final String imageSrc;
  final String username;
  final String userId;
  final String userAge;
  final BoxFit fit;
  const CustomCard({
    required this.imageSrc,
    required this.username,
    required this.userId,
    required this.userAge,
    this.fit = BoxFit.cover,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageSrc),
          fit: fit,
        ),
        color: AppColors.colorRedB,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: Get.width,
              padding: const EdgeInsetsDirectional.all(8),
              decoration: BoxDecoration(
                color: AppColors.colorDarkA.withOpacity(0.2),
                borderRadius: const BorderRadiusDirectional.vertical(bottom: Radius.circular(15))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: AppTextStyle.appTextStyle(
                        textColor: AppColors.colorWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Text(
                        userId,
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
                          userAge,
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
            ),
          )
        ],
      ),
    );
  }
}
