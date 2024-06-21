import 'package:get/get.dart';

import '../modules/about_us/bindings/about_us_binding.dart';
import '../modules/about_us/views/about_us_view.dart';
import '../modules/account_settings/bindings/account_settings_binding.dart';
import '../modules/account_settings/views/account_settings_view.dart';
import '../modules/audio_call/bindings/audio_call_binding.dart';
import '../modules/audio_call/views/audio_call_view.dart';
import '../modules/bkash_withdraw/bindings/bkash_withdraw_binding.dart';
import '../modules/bkash_withdraw/views/bkash_withdraw_view.dart';
import '../modules/block_list/bindings/block_list_binding.dart';
import '../modules/block_list/views/block_list_view.dart';
import '../modules/call_history/bindings/call_history_binding.dart';
import '../modules/call_history/views/call_history_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/create_post/bindings/create_post_binding.dart';
import '../modules/create_post/views/create_post_view.dart';
import '../modules/details_images/bindings/details_images_binding.dart';
import '../modules/details_images/views/details_images_view.dart';
import '../modules/details_profile/bindings/details_profile_binding.dart';
import '../modules/details_profile/views/details_profile_view.dart';
import '../modules/edit_post/bindings/edit_post_binding.dart';
import '../modules/edit_post/views/edit_post_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/face_verification/bindings/face_verification_binding.dart';
import '../modules/face_verification/views/face_verification_view.dart';
import '../modules/favorite_list/bindings/favorite_list_binding.dart';
import '../modules/favorite_list/views/favorite_list_view.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/forget_password/views/forget_password_view.dart';
import '../modules/help_and_support/bindings/help_and_support_binding.dart';
import '../modules/help_and_support/views/help_and_support_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/invoice_details/bindings/invoice_details_binding.dart';
import '../modules/invoice_details/views/invoice_details_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/message/bindings/message_binding.dart';
import '../modules/message/views/message_view.dart';
import '../modules/my_timeline/bindings/my_timeline_binding.dart';
import '../modules/my_timeline/views/my_timeline_view.dart';
import '../modules/nagad_withdraw/bindings/nagad_withdraw_binding.dart';
import '../modules/nagad_withdraw/views/nagad_withdraw_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/notification_settings/bindings/notification_settings_binding.dart';
import '../modules/notification_settings/views/notification_settings_view.dart';
import '../modules/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/otp_verification/views/otp_verification_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/purchase_history/bindings/purchase_history_binding.dart';
import '../modules/purchase_history/views/purchase_history_view.dart';
import '../modules/recharge_directly/bindings/recharge_directly_binding.dart';
import '../modules/recharge_directly/views/recharge_directly_view.dart';
import '../modules/recharge_from_reward_balance/bindings/recharge_from_reward_balance_binding.dart';
import '../modules/recharge_from_reward_balance/views/recharge_from_reward_balance_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/registration_otp/bindings/registration_otp_binding.dart';
import '../modules/registration_otp/views/registration_otp_view.dart';
import '../modules/reward_history/bindings/reward_history_binding.dart';
import '../modules/reward_history/views/reward_history_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/terms_and_conditions/bindings/terms_and_conditions_binding.dart';
import '../modules/terms_and_conditions/views/terms_and_conditions_view.dart';
import '../modules/withdraw_history/bindings/withdraw_history_binding.dart';
import '../modules/withdraw_history/views/withdraw_history_view.dart';
import '../modules/withdraw_reward_point/bindings/withdraw_reward_point_binding.dart';
import '../modules/withdraw_reward_point/views/withdraw_reward_point_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    /// ----------------------------- splash screen ----------------------------
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    /// ----------------------------- login screen -----------------------------
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    /// ----------------------------- forget password screen --------------------------
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),

    /// ------------------------------ new password screen ----------------------------
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),

    /// ------------------------------ registration screen -----------------------
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
    ),

    /// -------------------------- home screen ----------------------
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    /// ----------------------- message screen ----------------------------
    GetPage(
      name: _Paths.MESSAGE,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),

    /// ------------------------ create post screen -----------------------
    GetPage(
      name: _Paths.CREATE_POST,
      page: () => const CreatePostView(),
      binding: CreatePostBinding(),
    ),

    /// ------------------------- notification screen ---------------------
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),

    /// -------------------------- profile screen --------------------------
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),

    /// --------------------------- favorite list screen ----------------------
    GetPage(
      name: _Paths.FAVORITE_LIST,
      page: () => const FavoriteListView(),
      binding: FavoriteListBinding(),
    ),

    /// -------------------------- call history screen -------------------------
    GetPage(
      name: _Paths.CALL_HISTORY,
      page: () => const CallHistoryView(),
      binding: CallHistoryBinding(),
    ),

    /// -------------------------- purchase history screen -------------------------
    GetPage(
      name: _Paths.PURCHASE_HISTORY,
      page: () => const PurchaseHistoryView(),
      binding: PurchaseHistoryBinding(),
    ),

    /// -------------------------- face verification screen -------------------------
    GetPage(
      name: _Paths.FACE_VERIFICATION,
      page: () => const FaceVerificationView(),
      binding: FaceVerificationBinding(),
    ),

    /// -------------------------- about us screen -------------------------
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),

    /// -------------------------- edit profile screen -------------------------
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),

    /// -------------------------- account settings screen -------------------------
    GetPage(
      name: _Paths.ACCOUNT_SETTINGS,
      page: () => const AccountSettingsView(),
      binding: AccountSettingsBinding(),
    ),

    /// -------------------------- notification settings screen -------------------------
    GetPage(
      name: _Paths.NOTIFICATION_SETTINGS,
      page: () => const NotificationSettingsView(),
      binding: NotificationSettingsBinding(),
    ),

    /// -------------------------- privacy policy screen -------------------------
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),

    /// -------------------------- otp verification screen -------------------------
    GetPage(
      name: _Paths.OTP_VERIFICATION,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),

    /// -------------------------- details profile screen -------------------------
    GetPage(
      name: _Paths.DETAILS_PROFILE,
      page: () => const DetailsProfileView(),
      binding: DetailsProfileBinding(),
    ),

    /// -------------------------- My Timeline screen -------------------------
    GetPage(
      name: _Paths.MY_TIMELINE,
      page: () => const MyTimelineView(),
      binding: MyTimelineBinding(),
    ),

    /// -------------------------- call history screen -------------------------
    GetPage(
      name: _Paths.BLOCK_LIST,
      page: () => const BlockListView(),
      binding: BlockListBinding(),
    ),

    /// -------------------------- chat screen ---------------------------------
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.REWARD_HISTORY,
      page: () => const RewardHistoryView(),
      binding: RewardHistoryBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_HISTORY,
      page: () => const WithdrawHistoryView(),
      binding: WithdrawHistoryBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_REWARD_POINT,
      page: () => const WithdrawRewardPointView(),
      binding: WithdrawRewardPointBinding(),
    ),
    GetPage(
      name: _Paths.BKASH_WITHDRAW,
      page: () => const BkashWithdrawView(),
      binding: BkashWithdrawBinding(),
    ),
    GetPage(
      name: _Paths.NAGAD_WITHDRAW,
      page: () => const NagadWithdrawView(),
      binding: NagadWithdrawBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION_OTP,
      page: () => const RegistrationOtpView(),
      binding: RegistrationOtpBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE_DETAILS,
      page: () => const InvoiceDetailsView(),
      binding: InvoiceDetailsBinding(),
    ),
    GetPage(
      name: _Paths.DETAILS_IMAGES,
      page: () => const DetailsImagesView(),
      binding: DetailsImagesBinding(),
    ),
    GetPage(
      name: _Paths.HELP_AND_SUPPORT,
      page: () => const HelpAndSupportView(),
      binding: HelpAndSupportBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_AND_CONDITIONS,
      page: () => const TermsAndConditionsView(),
      binding: TermsAndConditionsBinding(),
    ),
    GetPage(
      name: _Paths.AUDIO_CALL,
      page: () => const AudioCallView(),
      binding: AudioCallBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_POST,
      page: () => const EditPostView(),
      binding: EditPostBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGE_DIRECTLY,
      page: () => const RechargeDirectlyView(),
      binding: RechargeDirectlyBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGE_FROM_REWARD_BALANCE,
      page: () => const RechargeFromRewardBalanceView(),
      binding: RechargeFromRewardBalanceBinding(),
    ),
  ];
}
