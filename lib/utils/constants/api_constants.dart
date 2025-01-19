class ApiConstants {
  static const String baseUrl = "https://dhenu.chardhamstays.com";
  // static const String baseUrl = "http://192.168.1.13:8000";
  static const String version = "/api";

  static const String loginEndpoint = "$version/user/login";
  static const String registerEndpoint = "$version/user/register";
  static const String verifyOtpEndpoint = "$version/user/verify-code";
  static const String cowShedEndpoint = "$version/cow-shed";
  static const String languageEndpoint = "$version/languages";
  static const String donationEndpoint = "$version/cow-shed/donations";
  static const String paymentLinkEndpoint = "$version/payments/donation-link";
  static const String metricsEndpoint = "$version/metrics";
   static const String faqsEndpoint = "$version/faqs";
  static const String feedbacksEndpoint = "$version/feedbacks";
 static const String sendOtpEndpoint = '$version/user/password/forgot';
 static const String resetPasswordEndpoint = '$version/user/password/reset';
  static const String notificationsEndpoint = '$version/user';

  static const String kContentType = "Content-Type";
  static const String kApplictionJson = "application/json";
  static const String kAccept = "Accept";
  static const String kAuthorization = "Authorization";
}
