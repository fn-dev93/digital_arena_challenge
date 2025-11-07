import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
/// Failures represent errors that occur during business logic execution.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Failure when server returns an error response.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Failure when there's a network connectivity issue.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Failure when cache operations fail.
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
