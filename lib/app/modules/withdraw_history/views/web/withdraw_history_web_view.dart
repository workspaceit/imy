import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/date_convert_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/withdraw_history/controllers/withdraw_history_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';

class WithdrawHistoryWebView extends StatelessWidget {
  const WithdrawHistoryWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<WithdrawHistoryController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.toNamed(Routes.PROFILE),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "Withdraw History",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          body: controller.isLoading ? const Center(
            child: CircularProgressIndicator(color: AppColors.colorDarkA),
          ) : controller.withdrawHistoryList.isEmpty ? Center(
              child: Text(
                "No Withdraw History Available",
                textAlign: TextAlign.center,
                style: AppTextStyle.appTextStyle(
                    textColor: AppColors.colorDarkA,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),
              )
          ) :  SingleChildScrollView(
            padding: const EdgeInsetsDirectional.only(top: 20, start: 24, end: 24, bottom: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// content
                    ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const Gap(12),
                        itemCount: controller.withdrawHistoryList.length,
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "\$ ${controller.withdrawHistoryList[index].amount}".padLeft(2, "0"),
                                        style: AppTextStyle.appTextStyle(
                                            textColor: AppColors.colorDarkA,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      const Gap(12),
                                      Row(
                                        children: [
                                          Text(
                                            "${controller.withdrawHistoryList[index].points} ILU Points",
                                            style: AppTextStyle.appTextStyle(
                                                textColor: AppColors.colorDarkB,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          const Gap(12),
                                          Container(
                                              height: 3,
                                              width: 3,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.colorDarkB,
                                                  shape: BoxShape.circle
                                              )
                                          ),
                                          const Gap(8),
                                          Text(
                                              DateConvertHelper.isoStringToLocalDateOnly(controller.withdrawHistoryList[index].createdAt ?? ""),
                                              style: AppTextStyle.appTextStyle(
                                                  textColor: AppColors.colorDarkB,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400
                                              )
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Gap(4),
                                  controller.withdrawHistoryList[index].status == "pending" ? Container(
                                    padding: const EdgeInsetsDirectional.symmetric(vertical: 4, horizontal: 12),
                                    decoration: BoxDecoration(color: AppColors.colorYellow, borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "PENDING",
                                      style: AppTextStyle.appTextStyle(
                                          textColor: AppColors.colorDarkA,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ) : Container(
                                    padding: const EdgeInsetsDirectional.symmetric(vertical: 4, horizontal: 12),
                                    decoration: BoxDecoration(color: AppColors.colorGreen, borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "COMPLETED",
                                      style: AppTextStyle.appTextStyle(
                                          textColor: AppColors.colorWhite,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            controller.withdrawHistoryList[index].status == "pending" ? const SizedBox() : InkWell(
                              hoverColor: AppColors.colorWhite,
                              borderRadius: BorderRadius.circular(100),
                              onTap: () => Get.toNamed(Routes.INVOICE_DETAILS, arguments: controller.withdrawHistoryList[index].id ?? -1),
                              child: Container(
                                height: 40, width: 40,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: AppColors.colorLightWhite,
                                    shape: BoxShape.circle
                                ),
                                child: const Icon(Icons.save_alt_rounded, color: AppColors.colorDarkA, size: 20),
                              ),
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
