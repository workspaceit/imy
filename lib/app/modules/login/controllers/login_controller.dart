import 'dart:async';
import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/login/login_repo.dart';
import 'package:ilu/app/models/login/login_error_model.dart';
import 'package:ilu/app/models/login/login_response_model.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';

class LoginController extends GetxController {
  LoginRepo loginRepo;
  LoginController({required this.loginRepo});

  // ----------------- declare variables -------------------------
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSubmit = false;
  String accessToken = "";
  String tokenType = "";
  String userType = "";
  String refreshToken = "";
  
  String email = "";
  String phoneNumber = "";

  /// -------------------- this method is used for passing data to server
  Future<void> login() async{
    isSubmit = true;
    update();

    checkLoginValidation(username: usernameController.text.trim());
    
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(usernameController.text.trim())){
      email = usernameController.text.trim();
      ApiResponseModel responseModel = await loginRepo.userLogin(username: email, password: passwordController.text.trim());

      if(responseModel.statusCode == 200){
        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        accessToken = loginResponseModel.accessToken ?? "";
        tokenType = loginResponseModel.tokenType ?? "";
        refreshToken = loginResponseModel.refreshToken ?? "";

        await refreshUserToken(refreshToken);
      }else if(responseModel.statusCode == 400){
        LoginErrorModel model = LoginErrorModel.fromJson(jsonDecode(responseModel.responseJson));
        if(kIsWeb){
          AppUtils.errorSnackBarForWeb(model.errorDescription ?? "");
        }else {
          AppUtils.errorToastMessage(model.errorDescription ?? "");
        }
      }else{
        if(kIsWeb){
          AppUtils.errorSnackBarForWeb("Something went wrong. Try again");
        }else{
          AppUtils.errorToastMessage("Something went wrong. Try again");
        }
      }
    }

    if(RegExp(r'^0*(\d{3})-*(\d{3})-*(\d{4})$').hasMatch(usernameController.text.trim())){
      phoneNumber = usernameController.text.trim().replaceFirst(RegExp(r'^0+'), '');
      ApiResponseModel responseModel = await loginRepo.userLogin(username: phoneNumber, password: passwordController.text.trim());

      if(responseModel.statusCode == 200){
        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        accessToken = loginResponseModel.accessToken ?? "";
        tokenType = loginResponseModel.tokenType ?? "";
        refreshToken = loginResponseModel.refreshToken ?? "";
        await refreshUserToken(refreshToken);
      }else if(responseModel.statusCode == 400){
        LoginErrorModel model = LoginErrorModel.fromJson(jsonDecode(responseModel.responseJson));
        if(kIsWeb){
          AppUtils.errorSnackBarForWeb(model.errorDescription ?? "");
        }else {
          AppUtils.errorToastMessage(model.errorDescription ?? "");
        }
      }else{
        if(kIsWeb){
          AppUtils.errorSnackBarForWeb("Something went wrong. Try again");
        }else{
          AppUtils.errorToastMessage("Something went wrong. Try again");
        }
      }
    }

    isSubmit = false;
    update();
  }

  /// -------------------- this method is used to refresh token
  Future<void> refreshUserToken(String refreshToken) async {
    ApiResponseModel responseModel = await loginRepo.refreshToken(refreshToken: refreshToken);
    if (responseModel.statusCode == 200) {
      LoginResponseModel model = LoginResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      var accessToken = model.accessToken ?? "";
      var tokenType = model.tokenType ?? "";
      var refreshToken = model.refreshToken ?? "";

      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.accessTokenKey, accessToken);
      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.tokenTypeKey, tokenType);
      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.refreshTokenKey, refreshToken);

      await getUserData();

      if(accessToken == "" || accessToken.isEmpty){
        Get.offAllNamed(Routes.LOGIN);
      }else{
        clearAllData();
        if(kIsWeb){
          AppUtils.successSnackBarForWeb("Login Successfully");
        }else{
          AppUtils.successToastMessage("Login Successfully");
        }
        Get.offAllNamed(Routes.HOME);
      }
    } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      loginRepo.apiService.sharedPreferences.clear();
      Get.offAllNamed(Routes.LOGIN);
      if(kIsWeb){
        AppUtils.errorSnackBarForWeb("Contact with admin");
      }else{
        AppUtils.errorToastMessage("Contact with admin");
      }
    }else{
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  checkLoginValidation({required String username}){
    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(username) &&
    ! RegExp(r'^0*(\d{3})-*(\d{3})-*(\d{4})$').hasMatch(username)
    ){
      kIsWeb ? AppUtils.errorSnackBarForWeb("Please enter valid email/contact number ")
          : AppUtils.errorToastMessage("Please enter valid email/contact number ");
    }
  }

  String dateOfBirth = "";
  String userEmail = "";
  String username = "";
  String gender = "";
  String userPhoneCode = "";
  String userPhoneNumber = "";
  String profileImage = "";
  String currentUserId = "";
  String country = "";
  int userId = -1;
  int age = -1;
  int iluPoints = 0;
  int rewardPoints = 0;

  List<ProfileImages> profileImages = [];

  /// ---------------- get user data method ---------------------------
  Future<void> getUserData() async{
    ApiResponseModel responseModel = await loginRepo.getUserProfile();

    if(responseModel.statusCode == 200){
      ProfileResponseModel profileResponseModel = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      dateOfBirth = profileResponseModel.dateOfBirth ?? "";
      userEmail = profileResponseModel.email ?? "";
      username = "${profileResponseModel.firstName} ${profileResponseModel.lastName}";
      gender = profileResponseModel.gender ?? "";
      userPhoneCode = profileResponseModel.phoneCode ?? "";
      userPhoneNumber = profileResponseModel.phoneNumber ?? "";
      currentUserId = profileResponseModel.uniqueId ?? "";
      userType = profileResponseModel.userType ?? "";
      userId = profileResponseModel.id ?? -1;
      profileImages = profileResponseModel.profileImages ?? [];
      iluPoints = profileResponseModel.iluPoints ?? 0;
      rewardPoints = profileResponseModel.rewardPoints ?? 0;
      country = profileResponseModel.country ?? "";

      if(profileImages.isNotEmpty == true){
        profileImage = "${ApiUrlContainer.baseUrl}${profileImages[0].file}";
      }

      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.userDobKey, dateOfBirth);
      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.userEmailKey, userEmail);
      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.userNameKey, username);
      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.userGenderKey, gender);
      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.userPhoneCodeKey, userPhoneCode);
      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.userPhoneNumberKey, userPhoneNumber);
      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.currentUserIdKey, currentUserId);
      await loginRepo.apiService.sharedPreferences.setInt(LocalStorageHelper.userIdKey, userId);
      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.typeOfUserKey, userType);
      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.profileImageKey, profileImage);
      await loginRepo.apiService.sharedPreferences.setInt(LocalStorageHelper.userILUPointsKey, iluPoints < 0 ? 0 : iluPoints);
      await loginRepo.apiService.sharedPreferences.setInt(LocalStorageHelper.userRewardPointsKey, rewardPoints < 0 ? 0 : rewardPoints);
      await loginRepo.apiService.sharedPreferences.setString(LocalStorageHelper.userCountryKey, country);

      await loginRepo.apiService.sharedPreferences.setInt(LocalStorageHelper.idOfCurrentUserKey, userId);

    }

    update();
  }

  /// -------------------- this method is used to clear data -----------------------
  clearAllData(){
    usernameController.text = "";
    passwordController.text = "";
  }

  /// ---------------------- language selection toggle button ---------------------
  bool isSelectedLanguage = false;
  String selectedLanguage = "English";
  void changeLanguage(){
    isSelectedLanguage = !isSelectedLanguage;
    isSelectedLanguage ? selectedLanguage = "Bangla" : selectedLanguage = "English";

    print("selected lang: $selectedLanguage");
    update();
  }
}
