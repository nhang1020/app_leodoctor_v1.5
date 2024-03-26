import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController {
  final Connectivity _connectivity = Connectivity();

  checkConnect() {
    _connectivity.onConnectivityChanged.listen((event) {
      print(event);
    });
    // if (result == ConnectivityResult.none) {
    //   return false;
    // }
    // return true;
  }

  Future<bool> checkInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print('ok');
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print('ok');
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      print('No Internet');
      return false;
    }
    return false;
  }
}
