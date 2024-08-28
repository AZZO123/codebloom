import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkConnection {
  static Future<bool> isConnected() async {
    var connectivityResult = await InternetConnectionChecker().hasConnection;

    return connectivityResult;
  }
}
