import 'package:flutter/material.dart';
import 'package:ilu/app/core/utils/app_colors.dart';

class CustomLoadingButton extends StatelessWidget {
  const CustomLoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(99)),
      child: const SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
            color: AppColors.colorWhite, strokeWidth: 2),
      ),
    );
  }
}
