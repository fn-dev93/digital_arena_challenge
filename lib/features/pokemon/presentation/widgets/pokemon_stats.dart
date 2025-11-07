import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

/// Widget that displays Pokemon base stats with progress bars.
class PokemonStats extends StatelessWidget {
  final Map<String, int> stats;

  const PokemonStats({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final labelWidth = context.responsive(
      mobile: 100.0,
      tablet: 120.0,
      desktop: 140.0,
    );
    final valueWidth = context.responsive(
      mobile: 35.0,
      tablet: 40.0,
      desktop: 45.0,
    );
    final spacing = context.responsive(
      mobile: 4.0,
      tablet: 6.0,
      desktop: 8.0,
    );

    return Column(
      children: stats.entries.map((entry) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: spacing),
          child: Row(
            children: [
              SizedBox(
                width: labelWidth,
                child: Text(
                  _formatStatName(entry.key, l10n),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ResponsiveFontSize.body(context),
                  ),
                ),
              ),
              SizedBox(
                width: valueWidth,
                child: Text(
                  entry.value.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveFontSize.body(context),
                  ),
                ),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: entry.value / 255,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getStatColor(entry.value),
                  ),
                  minHeight: context.responsive(
                    mobile: 8.0,
                    tablet: 10.0,
                    desktop: 12.0,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Formats stat names from snake-case to localized names.
  String _formatStatName(String name, AppLocalizations l10n) {
    switch (name) {
      case 'hp':
        return l10n.hp;
      case 'attack':
        return l10n.attack;
      case 'defense':
        return l10n.defense;
      case 'special-attack':
        return l10n.specialAttack;
      case 'special-defense':
        return l10n.specialDefense;
      case 'speed':
        return l10n.speed;
      default:
        return name
            .split('-')
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' ');
    }
  }

  /// Returns a color based on the stat value.
  Color _getStatColor(int value) {
    if (value >= 150) return Colors.green;
    if (value >= 100) return Colors.blue;
    if (value >= 50) return Colors.orange;
    return Colors.red;
  }
}
