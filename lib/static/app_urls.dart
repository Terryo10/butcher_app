class AppUrls {
  // static const String baseUrl ='http://127.0.0.1:8000/';
  static const String baseUrl = 'http://192.168.139.73:8000';
  static const String api = '/api/';
  static String getProductImage(String imageUrl) =>
      '$baseUrl/storage/$imageUrl';
  static const String categories = '$baseUrl${api}categories';
}
