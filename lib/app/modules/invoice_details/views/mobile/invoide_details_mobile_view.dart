import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/invoice_details/controllers/invoice_details_controller.dart';

class InVoiceDetailsMobileView extends StatelessWidget {

  const InVoiceDetailsMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<InvoiceDetailsController>(
          builder: (controller) => Scaffold(
            backgroundColor: AppColors.colorWhite,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.colorWhite,
              leading: IconButton(
                  onPressed: () => Get.back(),
                  alignment: Alignment.center,
                  icon: SvgPicture.asset(AppIcons.arrowBack),
                  iconSize: 24),
              title: Text(
                "Invoice Details",
                textAlign: TextAlign.center,
                style: AppTextStyle.appTextStyle(
                    textColor: AppColors.colorDarkA,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 24),
                  child: IconButton(
                    onPressed: (){
                      controller.generateAndDownloadPdf();
                    },
                    icon: SvgPicture.asset(AppIcons.download),
                    alignment: Alignment.center,
                    iconSize: 24
                  ),
                )
              ],
            ),
            body: controller.isLoading ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.colorDarkA,
              ),
            ) : SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Name",
                          style: AppTextStyle.appTextStyle(
                            textColor: AppColors.colorDarkB,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Text(
                          controller.name,
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        )
                      )
                    ],
                  ),
                  const Gap(40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Unique ID",
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkB,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                          child: Text(
                            controller.uniqueId,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkA,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          )
                      )
                    ],
                  ),
                  const Gap(40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Withdrawn Balance",
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkB,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                          child: Text(
                            "${controller.points}",
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkA,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          )
                      )
                    ],
                  ),
                  const Gap(40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Received Amount",
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkB,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                          child: Text(
                            controller.receiveAmount,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkA,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          )
                      )
                    ],
                  ),
                  const Gap(40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Requested Date",
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkB,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                          child: Text(
                            controller.requestDate,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkA,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          )
                      )
                    ],
                  ),
                  const Gap(40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Confirmed Date",
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkB,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                          child: Text(
                            controller.confirmDate,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkA,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          )
                      )
                    ],
                  ),
                  // const Gap(40),
                  //
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       child: Text(
                  //         "Payment Method",
                  //         style: AppTextStyle.appTextStyle(
                  //             textColor: AppColors.colorDarkB,
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w400
                  //         ),
                  //       ),
                  //     ),
                  //     const Gap(12),
                  //     Expanded(
                  //         child: Text(
                  //           "Bkash",
                  //           style: AppTextStyle.appTextStyle(
                  //               textColor: AppColors.colorDarkA,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400
                  //           ),
                  //         )
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
