/// Error page widget
///
/// Displays when a route is not found or navigation error occurs.
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../utils/responsive.dart';

/// A widget that displays an error page when navigation fails
class ErrorPage extends StatelessWidget {
  /// The error message or URI that caused the error
  final String errorMessage;

  /// Creates an error page
  const ErrorPage({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final iconSize = context.responsive(
      mobile: 64.0,
      tablet: 80.0,
      desktop: 96.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.error),
      ),
      body: Center(
        child: Padding(
          padding: ResponsivePadding.all(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: iconSize, color: Colors.red),
              SizedBox(
                  height: context.responsive(
                mobile: 16.0,
                tablet: 20.0,
                desktop: 24.0,
              ),),
              Text(
                l10n.pageNotFound(errorMessage),
                style: TextStyle(fontSize: ResponsiveFontSize.body(context)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height: context.responsive(
                mobile: 16.0,
                tablet: 20.0,
                desktop: 24.0,
              ),),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: Text(l10n.goToHome),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
