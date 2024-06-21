import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';

class CustomDialog extends StatelessWidget {
  final Widget? dialogChild;
  final double horizontalInsetPadding;
  final double dialogInsidePadding;
  final double? width;

  const CustomDialog(
      {this.dialogChild,
      this.horizontalInsetPadding = 24,
      this.dialogInsidePadding = 24, this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: AppColors.colorWhite,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.symmetric(
          horizontal: horizontalInsetPadding, vertical: 24),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: width,
          alignment: Alignment.center,
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: dialogInsidePadding, vertical: dialogInsidePadding),
          decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.circular(20)),
          child: dialogChild,
        ),
      ),
    );
  }
}
