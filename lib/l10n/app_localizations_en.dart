// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pokédex - Digital Arena Challenge';

  @override
  String get error => 'Error';

  @override
  String pageNotFound(String uri) {
    return 'Page not found: $uri';
  }

  @override
  String get goToHome => 'Go to Home';

  @override
  String get pokedex => 'Pokédex';

  @override
  String get retry => 'Retry';

  @override
  String get physicalAttributes => 'Physical Attributes';

  @override
  String get height => 'Height';

  @override
  String get weight => 'Weight';

  @override
  String get abilities => 'Abilities';

  @override
  String get baseStats => 'Base Stats';

  @override
  String get hp => 'HP';

  @override
  String get attack => 'Attack';

  @override
  String get defense => 'Defense';

  @override
  String get specialAttack => 'Sp. Attack';

  @override
  String get specialDefense => 'Sp. Defense';

  @override
  String get speed => 'Speed';

  @override
  String get networkError => 'Network error. Please check your connection.';

  @override
  String get serverError => 'Server error. Please try again later.';

  @override
  String get cacheError => 'Failed to load cached data.';

  @override
  String get unexpectedError => 'An unexpected error occurred.';
}
