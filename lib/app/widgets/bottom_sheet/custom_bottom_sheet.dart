import 'package:flutter/material.dart';
import 'package:ilu/app/core/utils/app_colors.dart';

class CustomBottomSheet {
  static void customBottomSheet(
      {required BuildContext context,
      required Widget child,
      VoidCallback? voidCallback,
      bool isDialCode = false,
      Color backgroundColor = AppColors.colorWhite}) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) => isDialCode
            ? Container(
                height: MediaQuery.of(context).size.height * .8,
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12))),
                child: child,
              )
            : SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.decelerate,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 24),
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12))),
                    child: child,
                  ),
                ),
              )).then((value) {
      voidCallback;
    });
  }
}
