import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/failed_response_model.dart';
import 'package:ilu/app/core/global/success_response_model.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/account_settings/account_setting_repo.dart';
import 'package:ilu/app/models/dial_code/dial_code_model.dart';
import 'package:ilu/app/routes/app_pages.dart';

class AccountSettingsController extends GetxController {
  AccountSettingRepo repo;
  AccountSettingsController({required this.repo});

  TextEditingController emailController = TextEditingController();
  TextEditingController dialCodeController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController retypePassController = TextEditingController();

  bool isSwitch = false;
  changeSwitch(){
    isSwitch = !isSwitch;
    update();
  }

  getData(){
    emailController.text = "srk.king@gmail.com";
    dialCodeController.text = "+880";
    contactController.text = "123456789";
  }


  // dial code
  List<DialCodeModel> phoneCodeList = [
    DialCodeModel(
        countryName: "Afghanistan", countryCode: "AF", dialCode: "+93"),
    DialCodeModel(countryName: "Albania", countryCode: "AL", dialCode: "+355"),
    DialCodeModel(countryName: "Algeria", countryCode: "DZ", dialCode: "+213"),
    DialCodeModel(
        countryName: "AmericanSamoa", countryCode: "AS", dialCode: "+1684"),
    DialCodeModel(countryName: "Andorra", countryCode: "AD", dialCode: "+376"),
    DialCodeModel(countryName: "Angola", countryCode: "AO", dialCode: "+244"),
    DialCodeModel(
        countryName: "Antigua and Barbuda",
        countryCode: "AG",
        dialCode: "+1268"),
    DialCodeModel(countryName: "Argentina", countryCode: "AR", dialCode: "+54"),
    DialCodeModel(countryName: "Armenia", countryCode: "AM", dialCode: "+374"),
    DialCodeModel(countryName: "Australia", countryCode: "AU", dialCode: "+61"),
    DialCodeModel(countryName: "Austria", countryCode: "AT", dialCode: "+43"),
    DialCodeModel(
        countryName: "Azerbaijan", countryCode: "AZ", dialCode: "+994"),
    DialCodeModel(countryName: "Bahamas", countryCode: "BS", dialCode: "+1242"),
    DialCodeModel(countryName: "Bahrain", countryCode: "BH", dialCode: "+973"),
    DialCodeModel(
        countryName: "Bangladesh", countryCode: "BD", dialCode: "+880"),
    DialCodeModel(
        countryName: "Barbados", countryCode: "BB", dialCode: "+1246"),
    DialCodeModel(countryName: "Belarus", countryCode: "BY", dialCode: "+375"),
    DialCodeModel(countryName: "Belgium", countryCode: "BE", dialCode: "+32"),
    DialCodeModel(countryName: "Bermuda", countryCode: "BM", dialCode: "+1441"),
    DialCodeModel(countryName: "Bhutan", countryCode: "BT", dialCode: "+975"),
    DialCodeModel(countryName: "Bolivia", countryCode: "BO", dialCode: "+591"),
    DialCodeModel(
        countryName: "Bosnia and Herzegovina",
        countryCode: "BA",
        dialCode: "+387"),
    DialCodeModel(countryName: "Brazil", countryCode: "BR", dialCode: "+55"),
    DialCodeModel(countryName: "Bulgaria", countryCode: "BG", dialCode: "+359"),
    DialCodeModel(countryName: "Cambodia", countryCode: "KH", dialCode: "+855"),
    DialCodeModel(countryName: "Cameroon", countryCode: "CM", dialCode: "+237"),
    DialCodeModel(countryName: "Canada", countryCode: "CA", dialCode: "+1"),
    DialCodeModel(countryName: "Chad", countryCode: "TD", dialCode: "+235"),
    DialCodeModel(countryName: "Chile", countryCode: "CL", dialCode: "+56"),
    DialCodeModel(countryName: "China", countryCode: "CN", dialCode: "+86"),
    DialCodeModel(countryName: "Colombia", countryCode: "CO", dialCode: "+57"),
    DialCodeModel(
        countryName: "Costa Rica", countryCode: "CR", dialCode: "+506"),
    DialCodeModel(
        countryName: "Cote d'Ivoire", countryCode: "CI", dialCode: "+225"),
    DialCodeModel(countryName: "Croatia", countryCode: "HR", dialCode: "+385"),
    DialCodeModel(countryName: "Cyprus", countryCode: "CY", dialCode: "+357"),
    DialCodeModel(
        countryName: "Czech Republic", countryCode: "CZ", dialCode: "+420"),
    DialCodeModel(countryName: "Denmark", countryCode: "DK", dialCode: "+45"),
    DialCodeModel(countryName: "Ecuador", countryCode: "EC", dialCode: "+593"),
    DialCodeModel(countryName: "Egypt", countryCode: "EG", dialCode: "+20"),
    DialCodeModel(
        countryName: "El Salvador", countryCode: "SV", dialCode: "+503"),
    DialCodeModel(countryName: "Eritrea", countryCode: "ER", dialCode: "+291"),
    DialCodeModel(countryName: "Estonia", countryCode: "EE", dialCode: "+372"),
    DialCodeModel(countryName: "Ethiopia", countryCode: "ET", dialCode: "+251"),
    DialCodeModel(countryName: "Fiji", countryCode: "FJ", dialCode: "+679"),
    DialCodeModel(countryName: "Fiji", countryCode: "FJ", dialCode: "+679"),
    DialCodeModel(countryName: "Finland", countryCode: "FI", dialCode: "+358"),
    DialCodeModel(countryName: "France", countryCode: "FR", dialCode: "+33"),
    DialCodeModel(countryName: "Georgia", countryCode: "GE", dialCode: "+995"),
    DialCodeModel(countryName: "Germany", countryCode: "DE", dialCode: "+49"),
    DialCodeModel(countryName: "Ghana", countryCode: "GH", dialCode: "+233"),
    DialCodeModel(
        countryName: "Gibraltar", countryCode: "GI", dialCode: "+350"),
    DialCodeModel(countryName: "Greece", countryCode: "GR", dialCode: "+30"),
    DialCodeModel(
        countryName: "Greenland", countryCode: "GL", dialCode: "+299"),
    DialCodeModel(
        countryName: "Guatemala", countryCode: "GT", dialCode: "+502"),
    DialCodeModel(countryName: "Haiti", countryCode: "HT", dialCode: "+509"),
    DialCodeModel(
        countryName: "Vatican City", countryCode: "VA", dialCode: "+379"),
    DialCodeModel(countryName: "Honduras", countryCode: "HN", dialCode: "+504"),
    DialCodeModel(
        countryName: "Hong Kong", countryCode: "HK", dialCode: "+852"),
    DialCodeModel(countryName: "Hungary", countryCode: "HU", dialCode: "+36"),
    DialCodeModel(countryName: "Iceland", countryCode: "IS", dialCode: "+354"),
    DialCodeModel(countryName: "India", countryCode: "IN", dialCode: "+91"),
    DialCodeModel(countryName: "Indonesia", countryCode: "ID", dialCode: "+62"),
    DialCodeModel(countryName: "Iran", countryCode: "IR", dialCode: "+98"),
    DialCodeModel(countryName: "Iraq", countryCode: "IQ", dialCode: "+964"),
    DialCodeModel(countryName: "Ireland", countryCode: "IE", dialCode: "+353"),
    DialCodeModel(countryName: "Italy", countryCode: "IT", dialCode: "+39"),
    DialCodeModel(countryName: "Jamaica", countryCode: "JM", dialCode: "+1876"),
    DialCodeModel(countryName: "Japan", countryCode: "JP", dialCode: "+81"),
    DialCodeModel(countryName: "Jordan", countryCode: "JO", dialCode: "+962"),
    DialCodeModel(
        countryName: "Kazakhstan", countryCode: "KZ", dialCode: "+77"),
    DialCodeModel(countryName: "Kenya", countryCode: "KE", dialCode: "+254"),
    DialCodeModel(
        countryName: "North Korea", countryCode: "KP", dialCode: "+850"),
    DialCodeModel(
        countryName: "South Korea", countryCode: "KR", dialCode: "+82"),
    DialCodeModel(countryName: "Kuwait", countryCode: "KW", dialCode: "+965"),
    DialCodeModel(
        countryName: "Kyrgyzstan", countryCode: "KG", dialCode: "+996"),
    DialCodeModel(countryName: "Latvia", countryCode: "LV", dialCode: "+371"),
    DialCodeModel(countryName: "Lebanon", countryCode: "LB", dialCode: "+961"),
    DialCodeModel(countryName: "Liberia", countryCode: "LR", dialCode: "+231"),
    DialCodeModel(countryName: "Libyan", countryCode: "LY", dialCode: "+218"),
    DialCodeModel(
        countryName: "Lithuania", countryCode: "LT", dialCode: "+370"),
    DialCodeModel(
        countryName: "Luxembourg", countryCode: "LU", dialCode: "+352"),
    DialCodeModel(countryName: "Malaysia", countryCode: "MY", dialCode: "+60"),
    DialCodeModel(countryName: "Maldives", countryCode: "MV", dialCode: "+960"),
    DialCodeModel(countryName: "Mali", countryCode: "ML", dialCode: "+223"),
    DialCodeModel(countryName: "Malta", countryCode: "MT", dialCode: "+356"),
    DialCodeModel(countryName: "Mexico", countryCode: "MX", dialCode: "+52"),
    DialCodeModel(countryName: "Monaco", countryCode: "MC", dialCode: "+377"),
    DialCodeModel(countryName: "Mongolia", countryCode: "MN", dialCode: "+976"),
    DialCodeModel(countryName: "Morocco", countryCode: "MA", dialCode: "+212"),
    DialCodeModel(countryName: "Nepal", countryCode: "NP", dialCode: "+977"),
    DialCodeModel(
        countryName: "Netherlands", countryCode: "NL", dialCode: "+31"),
    DialCodeModel(
        countryName: "New Zealand", countryCode: "NZ", dialCode: "+64"),
    DialCodeModel(countryName: "Nigeria", countryCode: "NG", dialCode: "+234"),
    DialCodeModel(countryName: "Norway", countryCode: "NO", dialCode: "+47"),
    DialCodeModel(countryName: "Oman", countryCode: "OM", dialCode: "+968"),
    DialCodeModel(countryName: "Pakistan", countryCode: "PK", dialCode: "+92"),
    DialCodeModel(
        countryName: "Palestinian", countryCode: "PS", dialCode: "+970"),
    DialCodeModel(countryName: "Paraguay", countryCode: "PY", dialCode: "+595"),
    DialCodeModel(countryName: "Peru", countryCode: "PE", dialCode: "+63"),
    DialCodeModel(
        countryName: "Philippines", countryCode: "PH", dialCode: "+63"),
    DialCodeModel(countryName: "Poland", countryCode: "PL", dialCode: "+48"),
    DialCodeModel(countryName: "Portugal", countryCode: "PT", dialCode: "+351"),
    DialCodeModel(
        countryName: "Puerto Rico", countryCode: "PR", dialCode: "+1939"),
    DialCodeModel(countryName: "Qatar", countryCode: "QA", dialCode: "+974"),
    DialCodeModel(countryName: "Romania", countryCode: "RO", dialCode: "+40"),
    DialCodeModel(countryName: "Russia", countryCode: "RU", dialCode: "+7"),
    DialCodeModel(
        countryName: "Saudi Arabia", countryCode: "SA", dialCode: "+966"),
    DialCodeModel(countryName: "Senegal", countryCode: "SN", dialCode: "+221"),
    DialCodeModel(countryName: "Serbia", countryCode: "RS", dialCode: "+381"),
    DialCodeModel(countryName: "Singapore", countryCode: "SG", dialCode: "+65"),
    DialCodeModel(countryName: "Slovakia", countryCode: "SK", dialCode: "+421"),
    DialCodeModel(countryName: "Slovenia", countryCode: "SI", dialCode: "+386"),
    DialCodeModel(
        countryName: "South Africa", countryCode: "ZA", dialCode: "+27"),
    DialCodeModel(countryName: "Spain", countryCode: "ES", dialCode: "+34"),
    DialCodeModel(countryName: "Sri Lanka", countryCode: "LK", dialCode: "+94"),
    DialCodeModel(countryName: "Sudan", countryCode: "SD", dialCode: "+249"),
    DialCodeModel(countryName: "Sweden", countryCode: "SE", dialCode: "+46"),
    DialCodeModel(
        countryName: "Switzerland", countryCode: "CH", dialCode: "+41"),
    DialCodeModel(countryName: "Syrian", countryCode: "SY", dialCode: "+963"),
    DialCodeModel(countryName: "Taiwan", countryCode: "TW", dialCode: "+886"),
    DialCodeModel(
        countryName: "Tajikistan", countryCode: "TJ", dialCode: "+992"),
    DialCodeModel(countryName: "Tanzania", countryCode: "TZ", dialCode: "+255"),
    DialCodeModel(countryName: "Thailand", countryCode: "TH", dialCode: "+66"),
    DialCodeModel(countryName: "Tonga", countryCode: "TO", dialCode: "+676"),
    DialCodeModel(
        countryName: "Trinidad and Tobago",
        countryCode: "TT",
        dialCode: "+1868"),
    DialCodeModel(countryName: "Tunisia", countryCode: "TN", dialCode: "+216"),
    DialCodeModel(countryName: "Turkey", countryCode: "TR", dialCode: "+90"),
    DialCodeModel(
        countryName: "Turkmenistan", countryCode: "TM", dialCode: "+993"),
    DialCodeModel(countryName: "Tuvalu", countryCode: "TV", dialCode: "+688"),
    DialCodeModel(countryName: "Uganda", countryCode: "UG", dialCode: "+256"),
    DialCodeModel(countryName: "Ukraine", countryCode: "UA", dialCode: "+380"),
    DialCodeModel(
        countryName: "United Arab Emirates",
        countryCode: "AE",
        dialCode: "+971"),
    DialCodeModel(
        countryName: "United States", countryCode: "US", dialCode: "+1"),
    DialCodeModel(countryName: "Uruguay", countryCode: "UY", dialCode: "+598"),
    DialCodeModel(
        countryName: "Uzbekistan", countryCode: "UZ", dialCode: "+998"),
    DialCodeModel(countryName: "Vanuatu", countryCode: "VU", dialCode: "+678"),
    DialCodeModel(countryName: "Venezuela", countryCode: "VE", dialCode: "+58"),
    DialCodeModel(countryName: "Vietnam", countryCode: "VN", dialCode: "+84"),
    DialCodeModel(
        countryName: "Virgin Islands, British",
        countryCode: "VG",
        dialCode: "+1284"),
    DialCodeModel(
        countryName: "Virgin Islands, U.S.",
        countryCode: "VI",
        dialCode: "+1340"),
    DialCodeModel(
        countryName: "Wallis and Futuna", countryCode: "WF", dialCode: "+681"),
    DialCodeModel(countryName: "Yemen", countryCode: "YE", dialCode: "+967"),
    DialCodeModel(countryName: "Zambia", countryCode: "ZM", dialCode: "+260"),
    DialCodeModel(countryName: "Zimbabwe", countryCode: "ZW", dialCode: "+263")
  ];
  int selectedPhoneCode = -1;

  // dial code for caller
  void changeCallerPhoneCode(int index) {
    selectedPhoneCode = index;
    dialCodeController.text = phoneCodeList[index].dialCode;
    Get.back();
    update();
  }

  /// ------------------------- change password section ------------------------
  bool isSubmit = false;
  changePassword() async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.userChangePassword(
        oldPass: currentPassController.text.trim(),
        newPass: newPassController.text.trim(),
        confirmPass: retypePassController.text.trim()
    );

    if(responseModel.statusCode == 200){
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      clearData();
      kIsWeb ?
      AppUtils.successSnackBarForWeb(model.message ?? "Change Password Successfully") :
      AppUtils.successToastMessage(model.message ?? "Change Password Successfully");
    }else if(responseModel.statusCode == 400){
      FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      kIsWeb ?
      AppUtils.errorSnackBarForWeb(model.message ?? "") :
      AppUtils.errorToastMessage(model.message ?? "");
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{
      FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      kIsWeb ?
      AppUtils.errorSnackBarForWeb(model.message ?? "") :
      AppUtils.errorToastMessage(model.message ?? "");
    }


    isSubmit = false;
    update();
  }

  clearData(){
    currentPassController.text = "";
    newPassController.text = "";
    retypePassController.text = "";
    update();
  }
}
