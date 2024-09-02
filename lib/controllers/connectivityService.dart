// lib/connectivity_service.dart

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();

  factory ConnectivityService() => _instance;

  ConnectivityService._internal() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result;
    });
  }

  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  Future<ConnectivityResult> checkConnectivity() async {
    _connectionStatus = await _connectivity.checkConnectivity();
    return _connectionStatus;
  }

  ConnectivityResult get connectionStatus => _connectionStatus;
}
