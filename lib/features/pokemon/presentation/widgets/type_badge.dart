import 'package:flutter/material.dart';

/// Widget that displays a Pokemon type badge with color coding.
class TypeBadge extends StatelessWidget {
  final String type;

  const TypeBadge({super.key, required this.type});

  /// Returns the color associated with each Pokemon type.
  Color _getTypeColor() {
    switch (type.toLowerCase()) {
      case 'normal':
        return Colors.grey;
      case 'fire':
        return Colors.orange;
      case 'water':
        return Colors.blue;
      case 'electric':
        return Colors.yellow;
      case 'grass':
        return Colors.green;
      case 'ice':
        return Colors.cyan;
      case 'fighting':
        return Colors.red;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'flying':
        return Colors.indigo;
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.blueGrey;
      case 'ghost':
        return Colors.deepPurple;
      case 'dragon':
        return Colors.deepOrange;
      case 'dark':
        return Colors.black87;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pinkAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _getTypeColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
