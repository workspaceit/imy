import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ilu/app/core/constants/string_constant.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';

class CustomBulletedList extends StatelessWidget {
  final String content;
  const CustomBulletedList({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          bullet,
          style: AppTextStyle.appTextStyle(
            textColor: AppColors.colorDarkB,
            fontWeight: FontWeight.w500,
            fontSize: 14
          ),
        ),
        const Gap(6),
        Expanded(
          child: Text(
            content,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: AppTextStyle.appTextStyle(
                textColor: AppColors.colorDarkB,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
          ),
        )
      ],
    );
  }
}
