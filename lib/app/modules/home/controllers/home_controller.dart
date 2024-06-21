import 'dart:convert';
import 'dart:io';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/constants/country/country_list.dart';
import 'package:ilu/app/core/global/success_response_model.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/home/home_repo.dart';
import 'package:ilu/app/models/default_setting/default_setting_response_model.dart';
import 'package:ilu/app/models/home/get_users_response_model.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';

import '../../../models/city/city_response_model.dart' as c;
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  HomeRepo homeRepo;

  final AudioPlayer audioPlayer = AudioPlayer();
  HomeController({required this.homeRepo});

  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  /// ---------------------- this method is used to initial state of the screen
  int page = 0;
  String nextPageUrl = "";

  bool isPagination = false;
  Future<void> loadPaginationData() async{
    isPagination = true;
    update();
    await loadUserData();

    isPagination = false;
    update();
  }

  initialState() async {
    searchController.text = "";
    isLoading = true;
    update();

    page = 0;
    userDataList.clear();
    cityList.clear();
    // playRingtone() ;

    await getUserData();
    await loadUserData();
    await getCityData();
    await getDefaultSetting();
    //await refreshUserToken();

    isLoading = false;
    update();
  }

  /// ---------------------- this method is used to get user info
  int rechargeBalance = 0;
  int rewardPoints = 0;

  void playRingtone() async {
     await audioPlayer.setSource(AssetSource('ringtone/incoming_call.mp3'));
    audioPlayer.play(AssetSource('ringtone/incoming_call.mp3'));
  }
  Future<void> getUserData() async{
    ApiResponseModel responseModel = await homeRepo.getUserProfile();

    if(responseModel.statusCode == 200){
      ProfileResponseModel profileResponseModel = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      rechargeBalance = profileResponseModel.iluPoints ?? 0;
      if(rechargeBalance < 0){
        rechargeBalance = 0;
      }
      rewardPoints = profileResponseModel.rewardPoints ?? 0;
      if(rewardPoints < 0){
        rewardPoints = 0;
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }

    update();
  }


  /// ------------------------------ this method is used to fetch data from server
  int totalPage = 0;
  GetUsersResponseModel getUsersResponseModel = GetUsersResponseModel();
  List<Results> userDataList = [];

  Future<void> loadUserData() async {
    page = page + 1;

    if(page == 0){
      userDataList.clear();
    }
    ApiResponseModel apiResponseModel = await homeRepo.getUsersData(
        page: page,
        keyword: searchController.text.trim(),
        gender: selectedGender == 0 ? "" : genderList[selectedGender].toLowerCase(),
        cityId: cityId == 0 ? 0 : cityId,
        country: country == "" ? "" : country
    );
    if (apiResponseModel.statusCode == 200) {
      getUsersResponseModel = GetUsersResponseModel.fromJson(jsonDecode(apiResponseModel.responseJson));
      nextPageUrl = getUsersResponseModel.next ?? "";
      totalPage = getUsersResponseModel.totalPage ?? 0;
      List<Results>? tempList = getUsersResponseModel.results;
      if (tempList != null && tempList.isNotEmpty) {
        userDataList.addAll(tempList);
      }

    }else if (apiResponseModel.statusCode == 401 || apiResponseModel.statusCode == 403){

    } else {}
  }

  bool hasNext(){
    return nextPageUrl.isNotEmpty && nextPageUrl != null ? true : false;
  }

  /// ----------------------------- gender
  List<String> genderList = ["All", "Male", "Female"];
  int selectedGender = 0;
  String gender = "All";

  /// --------------------- this method is used to select gender
  chooseGender(int index) async {
    isFilterLoading = true;
    update();

    page = 0;
    userDataList.clear();

    selectedGender = index;
    gender = genderList[selectedGender];

    await loadUserData();

    isFilterLoading = false;
    update();
  }

  /// ----------------------------- city
  int selectedCityIndex = -1;
  int cityId = 0;
  String district = "";
  String country = "";

  /// ---------------- this method is used to choose city
  chooseCity(int index) async {
    isFilterLoading = true;
    update();

    page = 0;
    userDataList.clear();

    selectedCityIndex = index;
    district = cityList[selectedCityIndex].name ?? "";
    cityId = cityList[selectedCityIndex].id ?? 0;
    await loadUserData();

    isFilterLoading = false;
    update();
  }

  /// ------------------- this method is used to choose country
  int selectedCountryIndex = -1;
  chooseCountry(int index, BuildContext context) async {
    isFilterLoading = true;
    update();

    page = 0;
    userDataList.clear();

    selectedCountryIndex = index;
    country = countryList[selectedCountryIndex].name;

    if(country == "Bangladesh"){
      Get.back();
      openDistrictBottomSheet(context);
    }else{
      Get.back();
      selectedCityIndex = -1;
      district = "";
      cityId = 0;
      await loadUserData();
    }

    isFilterLoading = false;
    update();
  }

  /// --------------------------------- this method is used to search
  bool isFilterLoading = false;
  bool isFiltering = false;
  filterSearchData() async {
    isFilterLoading = true;
    update();

    page = 0;
    userDataList.clear();

    await loadUserData();

    isFilterLoading = false;
    update();
  }

  /// -------------------------- this method is used to send device info on server
  Future<void> requestDeviceInfo({required String deviceType, required String deviceIdentifier}) async {
    if(kIsWeb){
      ApiResponseModel responseModel = await homeRepo.registerDevice(
        deviceType: "web",
        deviceIdentifier: deviceIdentifier
      );

      if (responseModel.statusCode == 201) {
        SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        await homeRepo.apiService.sharedPreferences.setString(LocalStorageHelper.deviceTypeKey, deviceType);
      } else if (responseModel.statusCode == 400) {

      } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
        Get.offAllNamed(Routes.LOGIN);
      }else {

      }
      update();
    }else{
      ApiResponseModel responseModel = await homeRepo.registerDevice(
        deviceType: deviceType,
        deviceIdentifier: deviceIdentifier
      );

      if (responseModel.statusCode == 201) {
        SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        await homeRepo.apiService.sharedPreferences.setString(LocalStorageHelper.deviceTypeKey, deviceType);
        print("-------------- device type: ${homeRepo.apiService.sharedPreferences.getString(LocalStorageHelper.deviceTypeKey)}");
      } else if (responseModel.statusCode == 400) {

      } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
        Get.offAllNamed(Routes.LOGIN);
      }else {

      }
      update();
    }
  }

  /// -------------------- this method is used to get device info
  getDeviceInfo() async {
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // ----------------- for android, ios & web -------------------

       if (Platform.isAndroid) {
        // AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        await requestDeviceInfo(deviceType: "android", deviceIdentifier: AppUtils.fcmToken);
      }  else if (GetPlatform.isIOS) {
         await requestDeviceInfo(
            deviceType: 'ios',
            deviceIdentifier: AppUtils.fcmToken
        );
      } else if(GetPlatform.isWeb){
        print("------------- web platform ---------------");
        await requestDeviceInfo(
          deviceType: "web",
          deviceIdentifier: AppUtils.fcmToken
        );
      }
  }

  /// -------------------- this method is used to fetch district data from server
  c.CityResponseModel cityResponseModel = c.CityResponseModel();
  String city = "";
  List<c.City> cityList = [];

  Future<void> getCityData() async {
    ApiResponseModel responseModel = await homeRepo.getCity();

    if (responseModel.statusCode == 200) {
      c.CityResponseModel cityResponseModel =
      c.CityResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<c.City>? tempCityList = cityResponseModel.city;

      if (tempCityList != null && tempCityList.isNotEmpty) {
        cityList.clear();
        cityList.addAll(tempCityList);
      }
    } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else {
      AppUtils.errorToastMessage("Failed to Fetch Cities Data");
    }
  }

  /// ---------------------- this method is used to open district bottom sheet
  void openDistrictBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.colorWhite,
      shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))
        ),
      context: context, builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select District",
                  textAlign:
                  TextAlign.left,
                  style: AppTextStyle.appTextStyle(
                      textColor: AppColors.colorDarkA,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),
                ),
                IconButton(
                    onPressed: () async{
                      Get.back();
                      isFilterLoading = true;
                      update();
                      page = 0;
                      userDataList.clear();
                      selectedCityIndex = -1;
                      district = "";
                      cityId = 0;
                      await loadUserData();
                      isFilterLoading = false;
                      update();
                    },
                    iconSize: 20,
                    icon: const Icon(Icons.clear, color: AppColors.colorDarkA)
                )
              ],
            )
        ),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
            physics: const BouncingScrollPhysics(),
            child:
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: List.generate(cityList.length, (index) => InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: (){
                  chooseCity(index);
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                  margin: const EdgeInsetsDirectional.only(bottom: 8),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: index == selectedCityIndex ? const Color(0xff7017ff) : AppColors.colorWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: index == selectedCityIndex ? const Color(0xff7017ff) : AppColors.colorGrayB,
                          width: 1
                      )
                  ),
                  child: Text(
                    cityList[index].name ?? "",
                    style: AppTextStyle.appTextStyle(
                        textColor: index == selectedCityIndex ? AppColors.colorWhite : AppColors.colorDarkB,
                        fontSize: 14, fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              )),
            ),
          ),
        )
      ],
    ));
  }

  /// -------------------------- this method is used to withdraw reward balance
  void withdrawRewardPoints(){
    if(rewardPoints < lowestWithdrawalAmount){
      kIsWeb
          ? AppUtils.warningSnackBarForWeb("You don't have enough reward balance for withdrawal")
          : AppUtils.warningToastMessage("You don't have enough reward balance for withdrawal");
    }else if(rewardPoints == 0){
       kIsWeb
           ? AppUtils.warningSnackBarForWeb("You don't have enough reward balance for withdrawal")
           : AppUtils.warningToastMessage("You don't have enough reward balance for withdrawal");
    }else{
      Get.toNamed(Routes.WITHDRAW_REWARD_POINT);
    }
  }

  /// ---------------- this method is used to default setting
  int lowestWithdrawalAmount = 0;
  List<DefaultSettingResponseModel> settings = [];

  Future<void> getDefaultSetting() async{
    ApiResponseModel responseModel = await homeRepo.getDefaultSettingData();
    if(responseModel.statusCode == 200){
      List<dynamic> tempList = jsonDecode(responseModel.responseJson);
      if(tempList.isNotEmpty){
        settings = tempList.map((data) => DefaultSettingResponseModel.fromJson(data)).toList();
      }

      for(var settingData in settings){
        if(settingData.key == "lowest_withdrawal_amount"){
          lowestWithdrawalAmount = int.tryParse("${settingData.value}") ?? 0;
          update();
          print("------------ lowest withdrawal amount: $lowestWithdrawalAmount");
        }
      }
    }else if(responseModel.statusCode == 400){

    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{

    }
  }
}
