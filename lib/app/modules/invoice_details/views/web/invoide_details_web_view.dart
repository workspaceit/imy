import 'dart:io';
import 'dart:typed_data';
import "package:universal_html/html.dart" as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/invoice_details/controllers/invoice_details_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InVoiceDetailsWebView extends StatelessWidget {

  const InVoiceDetailsWebView({super.key});

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
                  onPressed: () => Get.toNamed(Routes.WITHDRAW_HISTORY),
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
                      onPressed: () async {
                        Uint8List pdfBytes = await generateAndDownloadPdfForWeb(controller);
                        //generateAndDownloadPdfForWeb(controller);
                        savePdf(pdfBytes, "Invoice Details");
                      },
                      icon: SvgPicture.asset(AppIcons.download),
                      alignment: Alignment.center, iconSize: 24
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
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 600,
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
                              "Received BDT Amount",
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
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }

  Future<Uint8List> generateAndDownloadPdfForWeb(InvoiceDetailsController controller) async{
    final ByteData image = await rootBundle.load('assets/images/app_logo.png');
    Uint8List imageData = (image).buffer.asUint8List();

    final font = await PdfGoogleFonts.interRegular();

    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              /// ----------------------- image section
              pw.Align(
                alignment: pw.Alignment.topCenter,
                child: pw.Image(pw.MemoryImage(imageData), height: 200, width: 200),
              ),
              pw.SizedBox(height: 16),
              /// ----------------------- details section
              pw.Container(
                  width: double.infinity,
                  margin: const pw.EdgeInsets.symmetric(horizontal: 40),
                  padding: const pw.EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.purple,
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text(
                      "Invoice Details",
                      style: pw.TextStyle(
                          font: font,
                          color: PdfColors.white,
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold
                      )
                  )
              ),
              pw.SizedBox(height: 16),
              /// ------------------------------- info
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 40),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Flexible(
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.RichText(
                                    text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                              text: "Invoice ID:  ",
                                              style: pw.TextStyle(
                                                  font: font,
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: 12
                                              )
                                          ),
                                          pw.TextSpan(
                                              text: controller.invoiceId_,
                                              style: pw.TextStyle(
                                                  font: font,
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.normal,
                                                  fontSize: 12
                                              )
                                          )
                                        ]
                                    )
                                ),
                                pw.SizedBox(height: 12),
                                pw.RichText(
                                    text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                              text: "Name:  ",
                                              style: pw.TextStyle(
                                                  font: font,
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: 12
                                              )
                                          ),
                                          pw.TextSpan(
                                              text: controller.name,
                                              style: pw.TextStyle(font: font, color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
                                          )
                                        ]
                                    )
                                ),
                                pw.SizedBox(height: 12),
                                pw.RichText(
                                    text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                              text: "Unique ID:   ",
                                              style: pw.TextStyle(
                                                  font: font,
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: 12
                                              )
                                          ),
                                          pw.TextSpan(
                                              text: controller.uniqueId,
                                              style: pw.TextStyle(font: font, color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
                                          )
                                        ]
                                    )
                                ),
                                pw.SizedBox(height: 12),
                                pw.RichText(
                                    text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                              text: "Withdrawn Balance:   ",
                                              style: pw.TextStyle(font: font, color: PdfColors.black, fontWeight: pw.FontWeight.bold, fontSize: 12)
                                          ),
                                          pw.TextSpan(
                                              text: "${controller.points}",
                                              style: pw.TextStyle(font: font, color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
                                          )
                                        ]
                                    )
                                ),
                                pw.SizedBox(height: 12),
                                pw.RichText(
                                    text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                              text: "Received Amount:   ",
                                              style: pw.TextStyle(
                                                  font: font,
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: 12
                                              )
                                          ),
                                          pw.TextSpan(
                                              text: controller.receiveAmount,
                                              style: pw.TextStyle(font: font, color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
                                          )
                                        ]
                                    )
                                ),
                                pw.SizedBox(height: 12),
                                pw.RichText(
                                    text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                              text: "Requested Date:   ",
                                              style: pw.TextStyle(
                                                  font: font,
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: 12
                                              )
                                          ),
                                          pw.TextSpan(
                                              text: controller.requestDate,
                                              style: pw.TextStyle(font: font, color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
                                          )
                                        ]
                                    )
                                ),
                                pw.SizedBox(height: 12),
                                pw.RichText(
                                    text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                              text: "Confirmed Date:   ",
                                              style: pw.TextStyle(
                                                  font: font,
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: 12
                                              )
                                          ),
                                          pw.TextSpan(
                                              text: controller.confirmDate,
                                              style: pw.TextStyle(font: font, color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
                                          )
                                        ]
                                    )
                                ),
                              ]
                          )
                      ),
                    ]
                ),
              ),
            ]
        )
    ));


    // Get external storage directory
    // await Printing.layoutPdf(
    //     name: "Invoice Details",
    //     onLayout: (PdfPageFormat format) async => pdf.save()
    // );

    return pdf.save();
  }

  void savePdf(Uint8List pdfBytes, String fileName) {
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute('download', '$fileName.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
