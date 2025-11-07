/// Contract for checking network connectivity.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementation of NetworkInfo.
/// Currently returns true by default.
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // In production, use connectivity_plus package
    return true;
  }
}
