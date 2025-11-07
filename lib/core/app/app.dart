/// Application configuration for different environments
///
/// This file contains the main application widget with localization support.
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../l10n/app_localizations.dart';
import '../navigation/app_router.dart';

/// Main application widget with localization and routing configured
class App extends StatelessWidget {
  /// Title suffix for the environment (e.g., "Development", "Production")
  final String? environmentTitle;

  /// Seed color for the theme
  final Color seedColor;

  /// Creates an App widget
  const App({
    super.key,
    this.environmentTitle,
    this.seedColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.createRouter();
    final title = environmentTitle != null
        ? 'Pokédex - Digital Arena Challenge ($environmentTitle)'
        : 'Pokédex - Digital Arena Challenge';

    return MaterialApp.router(
      title: title,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
