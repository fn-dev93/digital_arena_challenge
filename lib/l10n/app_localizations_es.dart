// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Pokédex - Desafío Digital Arena';

  @override
  String get error => 'Error';

  @override
  String pageNotFound(String uri) {
    return 'Página no encontrada: $uri';
  }

  @override
  String get goToHome => 'Ir al Inicio';

  @override
  String get pokedex => 'Pokédex';

  @override
  String get retry => 'Reintentar';

  @override
  String get physicalAttributes => 'Atributos Físicos';

  @override
  String get height => 'Altura';

  @override
  String get weight => 'Peso';

  @override
  String get abilities => 'Habilidades';

  @override
  String get baseStats => 'Estadísticas Base';

  @override
  String get hp => 'PS';

  @override
  String get attack => 'Ataque';

  @override
  String get defense => 'Defensa';

  @override
  String get specialAttack => 'At. Especial';

  @override
  String get specialDefense => 'Def. Especial';

  @override
  String get speed => 'Velocidad';

  @override
  String get networkError => 'Error de red. Por favor verifica tu conexión.';

  @override
  String get serverError => 'Error del servidor. Por favor intenta más tarde.';

  @override
  String get cacheError => 'Error al cargar datos en caché.';

  @override
  String get unexpectedError => 'Ocurrió un error inesperado.';
}
