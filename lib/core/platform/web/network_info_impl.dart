
import 'package:connectivity/connectivity.dart';
import 'package:test_color_project/core/network/network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    
    var connectivityResult = await Connectivity().checkConnectivity();
    return _getStatus(connectivityResult);
  }

  bool _getStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }


}