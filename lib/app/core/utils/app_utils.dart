import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';

class AppUtils {

  static var fcmToken = '';
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static successToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static errorToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.TOP,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static warningToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: const Color(0xffFFD000),
      textColor: AppColors.colorDarkA,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static successSnackBarForWeb(String message) {
    Get.snackbar(
      "Success",
      message,
      colorText: AppColors.colorWhite,
      backgroundColor: AppColors.colorGreen,
      snackPosition: SnackPosition.TOP,
      maxWidth: 400,
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 100)
    );
  }

  static warningSnackBarForWeb(String message) {
    Get.snackbar(
        "Warning",
        message,
        colorText: AppColors.colorDarkA,
        backgroundColor: AppColors.colorYellow,
        snackPosition: SnackPosition.TOP,
        maxWidth: 400,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 100)
    );
  }

  static errorSnackBarForWeb(String message) {
    Get.snackbar(
        "Error",
        message,
        colorText: AppColors.colorWhite,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        maxWidth: 400,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 100)
    );
  }

  static webNotificationMessage({required String title, required String message}) {
    Get.snackbar(
        title,
        message,
        colorText: AppColors.colorWhite,
        backgroundColor: Colors.purple,
        snackPosition: SnackPosition.TOP,
        maxWidth: 400,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 100)
    );
  }
}
