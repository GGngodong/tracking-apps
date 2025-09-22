import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

class ConnectionCheck {
  Logger log = Logger();

  Future<bool> hasConnection() async {
    var connectionResult = await (Connectivity().checkConnectivity());
    if (connectionResult != ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}
