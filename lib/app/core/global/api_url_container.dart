class ApiUrlContainer{

  static const String baseUrl = "";

  // ----------------- Authentication --------------------
  static const String loginEndPoint = "/api/auth/token/";
  static const String registrationEndPont = "/api/registration/";
  static const String verificationImageEndPoint = "/api/upload-verification-image/";

  static const String userProfileEndPoint = "/api/user-profile/";
  static const String sendVerificationCodeEndPoint = "/api/send-verification-code/";
  static const String matchVerificationCodeEndPoint = "/api/match-verification-code/";

  // ----------------- forget password -------------------------------------
  static const String forgetPasswordEmailEndPoint = "/api/forget-password/";
  static const String forgetPasswordPhoneEndPoint = "/api/forget-password/";
  static const String checkResetPasswordEndPoint = "/api/reset-password/";
  static const String resetPasswordEndPoint = "/api/reset-password/";

  // ----------------- City -------------------------------
  static const String getCityEndPoint = "/api/city/";

  // ----------------- home -------------------------------
  static const String getUserEndPoint = "/api/users/";
  static const String getUserDetailsEndPoint = "/api/users/";

  // ----------------- details profile --------------------
  static const String reportUserEndPoint = "/api/report-user/";
  static const String makeFavoriteUserEndPoint = "/api/favorite-user/";
  static const String makeBlockUserEndPoint = "/api/block-user/";
  static const String makeFavoriteImageEndPoint = "/api/favorite-image/";
  static const String removeFavoriteImageEndPoint = "/api/remove-favorite-image/";

  // ----------------- Profile ----------------------------
  static const String getFavoriteUserEndPoint = "/api/favorite-users/";
  static const String deleteFavoriteUserEndPoint = "/api/delete-favorite-user/";
  static const String getBlockUserEndPoint = "/api/block-users/";
  static const String unblockUserEndPoint = "/api/unblock-user/";

  // ------------------ Post -----------------------------
  static const String getAllPostEndPoint = "/api/post/";
  static const String createPostEndPoint = "/api/post/";
  static const String likePostEndPoint = "/api/like-post/";
  static const String unlikePostEndPoint = "/api/unlike-post/";
  static const String deletePostEndPoint = "/api/post/";
  static const String postLikedUsersEndPoint = "/api/post-liked-users/";

  // ------------------ Edit Profile ----------------------
  static const String updateProfileEndPoint = "/api/user-profile/";
  static const String uploadFilesEndPoint = "/api/files/";

  // ------------------ logout --------------------------
  static const String logoutEndPoint = "/api/auth/revoke_token/";

  // ------------------ points -----------------------------
  static const String bankWithdrawEndPoint = "/api/points-withdrawal/";
  static const String bkashWithdrawEndPoint = "/api/points-withdrawal/";
  static const String nagadWithdrawEndPoint = "/api/points-withdrawal/";

  // ------------------ ilu points ---------------------
  static const String iluPackagesEndPoint = "/api/packages/";

  // ------------------ ilu reward ---------------------
  static const String getRewardHistoryEndPont = "/api/reward-history/";
  static const String getWithdrawHistoryEndPont = "/api/points-withdrawal/";

  // ------------------ register device ---------------------
  static const String registerDeviceEndPoint = "/api/register-device/";

  // ------------------ invoice -----------------------------
  static const String invoiceEndPoint = "/api/get-invoice/";

  // ------------------ change password ---------------------
  static const String changePasswordEndPoint = "/api/change-user-password/";

  // ------------------ delete image ------------------------
  static const String deleteProfileImageEndPoint = "/api/files/";

  // ------------------ recharge ----------------------------
  static const String rechargeDirectlyEndPoint = "";
  static const String rechargeFromRewardEndPoint = "/api/recharge-by-reward/";
  static const String rechargeHistoryEndPoint = "/api/recharge-history/";

  // ------------------ default setting ---------------------
  static const String defaultSettingsEndPoint = "/api/default-settings/";
}