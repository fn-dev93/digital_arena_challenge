/// Custom Bloc Observer for monitoring Cubit state changes
///
/// This observer logs all state transitions, events, and errors
/// in Cubits/Blocs throughout the application.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Observer that monitors all Bloc/Cubit instances in the app
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      debugPrint('🟢 onCreate -- ${bloc.runtimeType}');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      debugPrint('🔵 onChange -- ${bloc.runtimeType}');
      debugPrint('   Current State: ${change.currentState}');
      debugPrint('   Next State: ${change.nextState}');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      debugPrint('🔴 onError -- ${bloc.runtimeType}');
      debugPrint('   Error: $error');
      debugPrint('   StackTrace: $stackTrace');
    }
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      debugPrint('🔴 onClose -- ${bloc.runtimeType}');
    }
  }
}
