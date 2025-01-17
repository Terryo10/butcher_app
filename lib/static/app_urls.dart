class AppUrls {
<<<<<<< HEAD
  // static const String baseUrl ='http://127.0.0.1:8000/';
  static const String baseUrl = 'http://192.168.139.73:8000';
  static const String api = '/api/';
  static String getProductImage(String imageUrl) =>
      '$baseUrl/storage/$imageUrl';
  static String searchProducts(String name) => '$baseUrl/api/search/$name';
=======
  // Base URLs
  static const String baseUrl = 'http://192.168.0.246:3000';
  static const String api = '/api/';
  static const String apiBase = '$baseUrl$api';

  // Helper methods
  static String getProductImage(String imageUrl) => '$baseUrl/storage/$imageUrl';

  // Categories
>>>>>>> 65b6a10d8e43a81cb3b040458620f180c0787276
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
}