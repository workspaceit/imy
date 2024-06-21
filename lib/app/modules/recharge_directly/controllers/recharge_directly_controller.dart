import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/data/recharge_directly/recharge_directly_repo.dart';

class RechargeDirectlyController extends GetxController {
  RechargeDirectlyRepo repo;
  RechargeDirectlyController({required this.repo});

  TextEditingController rechargeAmountController = TextEditingController();
  bool isSubmit = false;
}
