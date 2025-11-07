/// Responsive utilities for building adaptive layouts
///
/// This file provides utilities to create responsive designs that adapt
/// to different screen sizes and orientations.
library;

import 'package:flutter/material.dart';

/// Breakpoints for responsive design
class Breakpoints {
  /// Mobile devices (phones in portrait)
  static const double mobile = 600;

  /// Tablet devices (tablets in portrait, large phones in landscape)
  static const double tablet = 900;

  /// Desktop devices (tablets in landscape, desktop monitors)
  static const double desktop = 1200;

  /// Large desktop displays
  static const double largeDesktop = 1800;
}

/// Device type based on screen width
enum DeviceType {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

/// Extension on BuildContext for responsive utilities
extension ResponsiveContext on BuildContext {
  /// Get the current screen width
  double get width => MediaQuery.of(this).size.width;

  /// Get the current screen height
  double get height => MediaQuery.of(this).size.height;

  /// Check if the screen is in landscape orientation
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Check if the screen is in portrait orientation
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  /// Get the current device type
  DeviceType get deviceType {
    if (width >= Breakpoints.largeDesktop) return DeviceType.largeDesktop;
    if (width >= Breakpoints.desktop) return DeviceType.desktop;
    if (width >= Breakpoints.tablet) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  /// Check if device is mobile
  bool get isMobile => deviceType == DeviceType.mobile;

  /// Check if device is tablet
  bool get isTablet => deviceType == DeviceType.tablet;

  /// Check if device is desktop
  bool get isDesktop =>
      deviceType == DeviceType.desktop || deviceType == DeviceType.largeDesktop;

  /// Get responsive value based on device type
  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    switch (deviceType) {
      case DeviceType.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.mobile:
        return mobile;
    }
  }
}

/// Responsive builder widget
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, context.deviceType);
  }
}

/// Responsive layout widget
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= Breakpoints.desktop) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= Breakpoints.tablet) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

/// Responsive grid delegate
class ResponsiveGridDelegate extends SliverGridDelegateWithFixedCrossAxisCount {
  ResponsiveGridDelegate({
    required BuildContext context,
    int mobileColumns = 2,
    int tabletColumns = 3,
    int desktopColumns = 4,
    int largeDesktopColumns = 6,
    double childAspectRatio = 1.0,
    double crossAxisSpacing = 12.0,
    double mainAxisSpacing = 12.0,
  }) : super(
          crossAxisCount: context.responsive(
            mobile: mobileColumns,
            tablet: tabletColumns,
            desktop: desktopColumns,
            largeDesktop: largeDesktopColumns,
          ),
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        );
}

/// Responsive padding helper
class ResponsivePadding {
  /// Get horizontal padding based on screen size
  static EdgeInsets horizontal(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: context.responsive(
        mobile: 16.0,
        tablet: 24.0,
        desktop: 32.0,
        largeDesktop: 48.0,
      ),
    );
  }

  /// Get vertical padding based on screen size
  static EdgeInsets vertical(BuildContext context) {
    return EdgeInsets.symmetric(
      vertical: context.responsive(
        mobile: 12.0,
        tablet: 16.0,
        desktop: 20.0,
        largeDesktop: 24.0,
      ),
    );
  }

  /// Get all-around padding based on screen size
  static EdgeInsets all(BuildContext context) {
    return EdgeInsets.all(
      context.responsive(
        mobile: 16.0,
        tablet: 24.0,
        desktop: 32.0,
        largeDesktop: 48.0,
      ),
    );
  }
}

/// Responsive font sizes
class ResponsiveFontSize {
  /// Title font size
  static double title(BuildContext context) {
    return context.responsive(
      mobile: 24.0,
      tablet: 28.0,
      desktop: 32.0,
      largeDesktop: 36.0,
    );
  }

  /// Subtitle font size
  static double subtitle(BuildContext context) {
    return context.responsive(
      mobile: 18.0,
      tablet: 20.0,
      desktop: 22.0,
      largeDesktop: 24.0,
    );
  }

  /// Body font size
  static double body(BuildContext context) {
    return context.responsive(
      mobile: 14.0,
      tablet: 16.0,
      desktop: 16.0,
      largeDesktop: 18.0,
    );
  }

  /// Caption font size
  static double caption(BuildContext context) {
    return context.responsive(
      mobile: 12.0,
      tablet: 13.0,
      desktop: 14.0,
      largeDesktop: 15.0,
    );
  }
}
