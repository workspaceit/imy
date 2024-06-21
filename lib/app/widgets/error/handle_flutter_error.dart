import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';

class HandleFlutterErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorMsg;
  const HandleFlutterErrorWidget({required this.errorMsg, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60, width: 60,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle
            ),
            child: const Icon(Icons.clear, color: AppColors.colorWhite, size: 30),
          ),
          const Gap(24),
          Text(
            'Error Occurred!',
            style: AppTextStyle.appTextStyle(
              textColor: Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 20
            )
          ),
          const Gap(4),
          Text(
            errorMsg.exceptionAsString(),
            style: AppTextStyle.appTextStyle(
              textColor: AppColors.colorDarkB,
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
    );
  }
}
