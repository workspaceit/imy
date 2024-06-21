import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';

class CustomCardEmptyImage extends StatelessWidget {
  final String imageSrc;
  final String username;
  final String userId;
  final String userAge;

  const CustomCardEmptyImage({
    required this.imageSrc,
    required this.username,
    required this.userId,
    required this.userAge,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(imageSrc),
              fit: BoxFit.contain,
          ),
          color: AppColors.colorRedB,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.appTextStyle(
                      textColor: AppColors.colorDarkA,
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  ),
                ),
                const Gap(4),
                Row(
                  children: [
                    Text(
                        userId,
                        style: AppTextStyle.appTextStyle(
                            textColor: AppColors.colorDarkA,
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                        )
                    ),
                    const Gap(8),
                    Container(
                      height: 10,
                      width: 1,
                      color: AppColors.colorDarkA,
                    ),
                    const Gap(8),
                    Text(userAge,
                        style: AppTextStyle.appTextStyle(
                            textColor: AppColors.colorDarkA,
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
    );
  }
}