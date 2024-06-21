import 'dart:async';
import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/constants/country/country_list.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/global/success_response_model.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_static_text.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/registration/registration_repo.dart';
import 'package:ilu/app/models/city/city_response_model.dart' as c;
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/models/registration/registration_error_model.dart';
import 'package:ilu/app/models/registration/registration_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RegistrationController extends GetxController{

  RegistrationRepo registrationRepo;
  RegistrationController({required this.registrationRepo});


  // ------------------------- declare variables ------------------------------------
  bool rememberMe = false;
  bool useEmail = false;
  bool usePhoneNumber = false;
  int passwordLength = 0;
  bool isSubmit = false;
  String callerCountryCode = "";
  String callerContactNumber = "";

  String accessToken = "";
  String tokenType = "";

  String username = "";
  String dateOfBirth = "";
  String gender = "";
  String profileImage = "";
  String currentUserId = "";
  int id = 0;
  int iluPoints = 0;

  List<ProfileImages> profileImages = [];

  // ------------------------ for video_call receiver registration --------------------------------------------------
  TextEditingController usernameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reenterPasswordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  String dialCode = "";
  String contactNumber = "";

  /// -------------------- city 
  c.CityResponseModel cityResponseModel = c.CityResponseModel();
  String city = " ";
  List<c.City> cityList = [];
  bool isLoadingCity = false;

  /// ------------------ this method is used to get city data
  Future<void> getCityData() async{
    cityList.clear();
    isLoadingCity = true;
    update();

    ApiResponseModel responseModel = await registrationRepo.getCity();

    if(responseModel.statusCode == 200){
      c.CityResponseModel cityResponseModel = c.CityResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<c.City>? tempCityList = cityResponseModel.city;

      if(tempCityList != null && tempCityList.isNotEmpty){
        cityList.addAll(tempCityList);
      }
    }else{
      AppUtils.errorToastMessage("Failed to Fetch Cities Data");
    }

    isLoadingCity = false;
    update();
  }
  
  /// ---------------------- this method is used to choose district
  int selectedDistrictIndex = - 1;
  int districtId = 0;
  chooseCity(int index){
    Get.back();
    selectedDistrictIndex = index;
    districtController.text = cityList[selectedDistrictIndex].name ?? "";
    districtId = cityList[selectedDistrictIndex].id ?? 0;
    update();
  }

  /// ---------------------- this method is used to get country data
  int selectedCountryIndex = -1;
  chooseCountry(int index){
    Get.back();
    selectedCountryIndex = index;
    countryController.text = countryList[selectedCountryIndex].name;
    update();
  }


  // --------------------- agree terms and services ---------------------
  changeRememberMe() {
    rememberMe = !rememberMe;
    update();
  }

  /// ---------------- this method is used to pick dob for user
  void pickUserDateOfBirth(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050),
        builder: (context, child) => Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                primary: AppColors.colorDarkB,
              )),
              child: child!,
            ));

    if (pickedDate != null) {
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - pickedDate.year;
      if(currentDate.month < pickedDate.month || (currentDate.month == pickedDate.month && currentDate.day < pickedDate.day)){
        age--;
      }

      // -------------------- check if age is less than 18 ---------------
      if(age < 18){
        if(kIsWeb){
          AppUtils.warningSnackBarForWeb("You must be 18 years or older to register");
        }else{
          AppUtils.warningToastMessage("You must be 18 years or older to register");
        }
      }else {
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        dobController.text = formattedDate;
      }
    }
  }

  /// ---------------- gender section
  List<String> genderList = [AppStaticText.male.tr, AppStaticText.female.tr];
  int selectedGender = 0;

  /// ---------------------- this method is used to pick user gender
  pickUserGender(BuildContext context) {
    return showDialog(context: context, builder: (context) => CustomDialog(
        width: 425,
        dialogChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(AppStaticText.selectGender.tr,
                textAlign: TextAlign.center,
                style: AppTextStyle.appTextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w700),
                colors: const [
                  Color(0xffFFD000),
                  Color(0xffF80261),
                  Color(0xff7017FF)
                ]),
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  genderList.length,
                      (index) => GestureDetector(
                    onTap: () {
                      selectedGender = index;
                      genderController.text = genderList[selectedGender];
                      Get.back();
                      update();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: index == 2
                          ? null
                          : const EdgeInsetsDirectional.only(bottom: 12),
                      padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.colorDarkA, width: 0.5)),
                      child: Text(genderList[index],
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                  )),
            ),
          ],
        )
    ));
  }

  /// ----------------------- this method is used to check password length
  checkPasswordLength(String value) {
    passwordLength = value.length;
    update();
  }

  /// ---------------------- clear receiver form data -------------------------
  clearReceiverFormData(){
    usernameController.text = "";
    genderController.text = "";
    dobController.text = "";
    contactNumberController.text = "";
    emailController.text = "";
    countryController.text = "";
    passwordController.text = "";
    reenterPasswordController.text = "";
    districtController.text = "";
    selectedDistrictIndex = -1;
    districtId = 0;
    rememberMe = false;
    passwordLength = 0;
    update();
  }

  /// ------------------------ this method is used to send verification code
  sendPhoneVerificationCode(String phoneNumber) async{
    ApiResponseModel responseModel = await registrationRepo.sendVerificationCode(phoneNumber: phoneNumber);

    if(responseModel.statusCode == 200){
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      AppUtils.successSnackBarForWeb(model.message ?? "");
    }else{

    }
    update();
  }

  /// ------------------------ this method is used to send verification code
  sendEmailVerificationCode(String email) async{
    ApiResponseModel responseModel = await registrationRepo.sendVerificationCodeEmail(email: email);

    if(responseModel.statusCode == 200){
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      AppUtils.successSnackBarForWeb(model.message ?? "");
    }else{

    }
    update();
  }

  /// ------------------------------ register as foreign user
  registerAsForeignUser() async{
    isSubmit = true;
    update();

    List<String> callerNameSplit = usernameController.text.trim().split(' ');
    String firstName = callerNameSplit.first;
    String lastName = callerNameSplit.length > 1 ? callerNameSplit.last : "";

    if(callerNameSplit.length > 2){
      firstName = callerNameSplit.sublist(0, callerNameSplit.length - 1).join(' ');
    }


    ApiResponseModel responseModel = await registrationRepo.userRegistrationForForeignUser(
      firstName: firstName,
      lastName: lastName,
      gender: genderController.text.trim(),
      dateOfBirth: dobController.text.trim(),
      country: countryController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: reenterPasswordController.text.trim()
    );

    if(responseModel.statusCode == 201){
      RegistrationResponseModel model = RegistrationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      await registrationRepo.apiService.sharedPreferences.setString(LocalStorageHelper.emailKey, emailController.text.trim());
      await registrationRepo.apiService.sharedPreferences.setString(LocalStorageHelper.userTypeKey, countryController.text.trim());
      clearReceiverFormData();
      kIsWeb ? AppUtils.successSnackBarForWeb(model.message ?? "Registration Success") : AppUtils.successToastMessage(model.message ?? "Registration Success");
      kIsWeb ? Get.offAndToNamed(Routes.REGISTRATION_OTP) : Get.offAndToNamed(Routes.FACE_VERIFICATION);
    }else if(responseModel.statusCode == 400){
      RegistrationErrorModel model = RegistrationErrorModel.fromJson(jsonDecode(responseModel.responseJson));
      kIsWeb ? AppUtils.errorSnackBarForWeb(model.message ?? "") : AppUtils.errorToastMessage(model.message ?? "");
    }else{
      kIsWeb ? AppUtils.errorSnackBarForWeb("Something went wrong. Try again") : AppUtils.errorToastMessage("Something went wrong. Try again");
    }

    isSubmit = false;
    update();
  }

  /// ----------------------- this method is used for register as local user
  registerAsLocalUser() async{
    isSubmit = true;
    update();

    List<String> callerNameSplit = usernameController.text.trim().split(' ');
    String firstName = callerNameSplit.first;
    String lastName = callerNameSplit.length > 1 ? callerNameSplit.last : "";

    if(callerNameSplit.length > 2){
      firstName = callerNameSplit.sublist(0, callerNameSplit.length - 1).join(' ');
    }


    ApiResponseModel responseModel = await registrationRepo.userRegistrationForLocalUser(
        firstName: firstName,
        lastName: lastName,
        gender: genderController.text.trim(),
        dateOfBirth: dobController.text.trim(),
        country: countryController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: reenterPasswordController.text.trim(),
        cityId: districtId,
        phoneNumber: contactNumber,
        phoneCode: dialCode
    );

    if(responseModel.statusCode == 201){
      RegistrationResponseModel model = RegistrationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      await registrationRepo.apiService.sharedPreferences.setString(LocalStorageHelper.phoneNumberKey, contactNumber);
      await registrationRepo.apiService.sharedPreferences.setString(LocalStorageHelper.userTypeKey, countryController.text.trim());
      clearReceiverFormData();
      kIsWeb ? AppUtils.successSnackBarForWeb(model.message ?? "Registration Success") : AppUtils.successToastMessage(model.message ?? "Registration Success");
      kIsWeb ? Get.offAndToNamed(Routes.REGISTRATION_OTP) : Get.offAndToNamed(Routes.FACE_VERIFICATION);
    }else if(responseModel.statusCode == 400){
      RegistrationErrorModel model = RegistrationErrorModel.fromJson(jsonDecode(responseModel.responseJson));
      kIsWeb ? AppUtils.errorSnackBarForWeb(model.message ?? "") : AppUtils.errorToastMessage(model.message ?? "");
    }else{
      kIsWeb ? AppUtils.errorSnackBarForWeb("Something went wrong. Try again") : AppUtils.errorToastMessage("Something went wrong. Try again");
    }

    isSubmit = false;
    update();
  }
}
