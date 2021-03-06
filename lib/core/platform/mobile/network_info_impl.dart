
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:test_color_project/core/network/network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}