class AppApi {
  static String apikey = "123456789";
  static String url = "http://10.0.2.2:8000/api";
  static String IMAGEURL = 'http://10.0.2.2:8000/';
  static String LOGIN = '/user/login';
  static String Signup = '/user/register';
  static String store_plant = '/user/store_plant';
  static String plants = '/user/plants';
  static String update_plant(int id) => '/user/update_plant/$id';
  static String delete_photo(int id) => '/user/delete_photo/$id';
  static String get_plant(int id) => '/user/get_plant/$id';
  static String delete_plant(int id) => '/user/delete_plant/$id';
}
