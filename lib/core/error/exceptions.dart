/// Exception thrown when server returns an error.
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

/// Exception thrown when network request fails.
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

/// Exception thrown when cache operations fail.
class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}
