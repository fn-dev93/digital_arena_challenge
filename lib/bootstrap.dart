/// Bootstrap configuration for the application
///
/// This file contains the initialization logic that should run before
/// the app starts, including dependency injection setup, error handling,
/// and any other configuration needed.
library;

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/observers/app_bloc_observer.dart';
import 'injection_container.dart' as di;

/// Bootstraps the application with the provided widget.
///
/// This function initializes all dependencies and sets up error handling
/// before running the app.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set up Bloc observer for state management monitoring
  Bloc.observer = AppBlocObserver();

  // Set up error handling for Flutter framework errors
  FlutterError.onError = (details) {
    // Log the error
    FlutterError.presentError(details);

    if (kDebugMode) {
      // In debug mode, print full error details
      debugPrint('Flutter Error: ${details.exception}');
      debugPrint('Stack trace: ${details.stack}');
    }
  };

  // Set up error handling for async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      debugPrint('Async Error: $error');
      debugPrint('Stack trace: $stack');
    }
    return true;
  };

  // Initialize dependency injection
  await di.init();

  // Run the app
  runApp(await builder());
}
