class AppUrls {
  static const String baseUrl ='http://127.0.0.1:8000';
  // static const String baseUrl = 'http://192.168.139.73:8000';
  static const String api = '/api/';
  static String getProductImage(String imageUrl) =>
      '$baseUrl/storage/$imageUrl';
  static String searchProducts(String name) => '$baseUrl/api/search/$name';

  static const String apiBase = '$baseUrl$api';

  // Categories
  static const String categories = '$baseUrl${api}categories';

  // Authentication endpoints
  static const String auth = '${apiBase}auth';
  static const String register = '$auth/register';
  static const String login = '$auth/login';
  static const String logout = '$auth/logout';
  static const String verifyEmail = '$auth/verify-email';
  static const String verifyOtp = '$auth/verify-otp';

  // Social Authentication
  static const String googleAuth = '$auth/google';
  static const String googleCallback = '$auth/google/callback';
  static const String appleAuth = '$auth/apple';
  static const String appleCallback = '$auth/apple/callback';

  // Password Reset
  static const String forgotPassword = '$auth/forgot-password';
  static const String resetPassword = '$auth/reset-password';
  
  // Cart Endpoints
  static const String cart = '${apiBase}cart';
  static const String cartAdd = '$cart/add';
  static const String cartUpdate = '$cart/update'; // Usage: '$cartUpdate/$itemId'
  static const String cartRemove = '$cart/remove'; // Usage: '$cartRemove/$itemId'
  static const String cartClear = '$cart/clear';
  static const String cartCouponApply = '$cart/coupon/apply';
  static const String cartCouponRemove = '$cart/coupon/remove';
  static const String cartSync = '$cart/sync';
}