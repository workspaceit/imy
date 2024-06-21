import 'package:get/get.dart';
import 'package:ilu/app/models/privacy_policy/privacy_policy_model.dart';

class PrivacyPolicyController extends GetxController {
  
  PrivacyPolicyController();

  List<PrivacyPolicyModel> privacyList = [
    PrivacyPolicyModel(
        title: "Privacy Policy",
        content: "Welcome to IMY – Your Connection to Meaningful Relationships! "
            "Your privacy and data security are of utmost importance to us. "
            "This Privacy Policy outlines how we collect, use, and protect your personal information within the IMY app."),
    PrivacyPolicyModel(
        title: "Information We Collect",
        content: [
          "Profile Information: To create an account, we collect your email address and optional profile details like name, gender, and interests.",
          "Interactions: We gather data on your interactions within the app, including swipes, matches, chats, and posts.",
          "Device Information: We collect device identifiers, IP address, and usage data for app optimization and troubleshooting.",
          "Location: We may collect your location data to provide you with location-based features (with your explicit consent)."
        ]
    ),
    PrivacyPolicyModel(
        title: "How We Use Your Information",
        content: [
          "We use your information to enhance your app experience, personalize content, and facilitate connections.",
          "Your data helps us provide you with relevant matches, posts, and notifications.",
          "We may use your email to send app updates, promotions, and other communications (you can opt-out anytime).",
        ]
    ),
    PrivacyPolicyModel(
        title: "Data Sharing",
        content: [
          "Your profile information is shared with potential matches when there's mutual interest (swipe right).",
          "We may share aggregated, non-identifiable data for analytics and marketing purposes.",
        ]
    ),
    PrivacyPolicyModel(
        title: "Data Security",
        content: [
          "We implement industry-standard security measures to protect your data from unauthorized access and breaches.",
          "However, no method of transmission over the internet is entirely secure, and we cannot guarantee absolute security.",
        ]
    ),
    PrivacyPolicyModel(
        title: "Your Choices",
        content: [
          "You can edit your profile information and interests at any time.",
          "You can adjust notification settings or delete your account when desired.",
          "You have the right to request access, correction, or deletion of your personal data."
        ]
    ),
    PrivacyPolicyModel(
        title: "Third-Party Services",
        content: "IMY may use third-party services for analytics, advertising, and other purposes. These services have their own privacy policies."),
    PrivacyPolicyModel(
        title: "Children's Privacy",
        content: "IMY is intended for users aged 18 and above. We do not knowingly collect personal information from children."),
    PrivacyPolicyModel(
        title: "Changes to Privacy Policy",
        content: [
          "We may update this Privacy Policy to reflect changes in our practices. Please review the policy periodically",
          "By using the IMY app, you consent to the collection, use, and sharing of your information as described in this Privacy Policy."
        ]),
  ];
}
