import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/invoice_details/controllers/invoice_details_controller.dart';
import 'package:ilu/app/modules/invoice_details/views/mobile/invoide_details_mobile_view.dart';
import 'package:ilu/app/modules/invoice_details/views/web/invoide_details_web_view.dart';


class InvoiceDetailsView extends StatefulWidget {
  const InvoiceDetailsView({super.key});

  @override
  State<InvoiceDetailsView> createState() => _InvoiceDetailsViewState();
}

class _InvoiceDetailsViewState extends State<InvoiceDetailsView> {
  int invoiceId = -1;

  @override
  void initState() {
    invoiceId = Get.arguments;
    final controller = Get.find<InvoiceDetailsController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadInvoiceData(invoiceId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: InVoiceDetailsMobileView(),
      desktopUI: InVoiceDetailsWebView(),
    );
  }
}
