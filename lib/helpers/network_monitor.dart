import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class NetworkMonitor {
  late ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();

  Future<List<ConnectivityResult>> initConnectivity() async {
    late List<ConnectivityResult> result;

    try {
      result = await connectivity.checkConnectivity();
      return result;
    } on PlatformException {
      return [];
    }
  }
}
