import 'dart:convert';
import 'dart:io';
import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/date_convert_helper.dart';
import 'package:ilu/app/data/invoice/invoice_repo.dart';
import 'package:ilu/app/models/invoice/invoice_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceDetailsController extends GetxController {

  InvoiceRepo repo;
  InvoiceDetailsController({required this.repo});

  InvoiceResponseModel model = InvoiceResponseModel();

  String name = "";
  String uniqueId = "";
  int points = 0;
  String receiveAmount = "";
  String requestDate = "";
  String confirmDate = "";
  String invoiceId_ = "";

  bool isLoading = false;

  Future<void> loadInvoiceData(int invoiceId) async{
    isLoading = true;
    update();

    ApiResponseModel responseModel = await repo.getInvoiceData(invoiceId: invoiceId);

    if(responseModel.statusCode == 200){
      model = InvoiceResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      invoiceId_ = "${model.invoice?.id ?? 0}";
      name = model.invoice?.name ?? "";
      uniqueId = model.invoice?.uniqueId ?? "";
      points = model.invoice?.points ?? 0;
      receiveAmount = "${model.invoice?.amount ?? 0}";
      requestDate = DateConvertHelper.isoStringToLocalFormattedDateOnly(model.invoice?.requestDate ?? "");
      confirmDate = DateConvertHelper.isoStringToLocalFormattedDateOnly(model.invoice?.invoiceDate ?? "");
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }

    isLoading = false;
    update();
  }

  /// ------------------------- this method is used to generate and download pdf
  void generateAndDownloadPdf() async{
    final ByteData image = await rootBundle.load('assets/images/app_logo.png');
    Uint8List imageData = (image).buffer.asUint8List();

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
                                            color: PdfColors.black,
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 12
                                        )
                                    ),
                                    pw.TextSpan(
                                        text: invoiceId_,
                                        style: pw.TextStyle(
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
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: 12
                                              )
                                          ),
                                          pw.TextSpan(
                                            text: name,
                                            style: pw.TextStyle(color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
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
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: 12
                                              )
                                          ),
                                          pw.TextSpan(
                                              text: uniqueId,
                                              style: pw.TextStyle(color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
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
                                              style: pw.TextStyle(color: PdfColors.black, fontWeight: pw.FontWeight.bold, fontSize: 12)
                                          ),
                                          pw.TextSpan(
                                              text: "$points",
                                              style: pw.TextStyle(color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
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
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: 12
                                              )
                                          ),
                                          pw.TextSpan(
                                              text: receiveAmount,
                                              style: pw.TextStyle(color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
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
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: 12
                                              )
                                          ),
                                          pw.TextSpan(
                                              text: requestDate,
                                              style: pw.TextStyle(color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
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
                                                  color: PdfColors.black,
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: 12
                                              )
                                          ),
                                          pw.TextSpan(
                                              text: confirmDate,
                                              style: pw.TextStyle(color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 12)
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
      final directory = await getExternalStorageDirectory();
      final path = directory?.path;

      // Save PDF to a file
      final file = File('$path/Invoice.pdf');
      await file.writeAsBytes(await pdf.save());
      await OpenFile.open(file.path);
  }
}
