import '../../domain/entities/entities.dart';

/// Data model for Pokemon that extends the domain entity.
/// Handles JSON serialization/deserialization from the API.
class PokemonModel extends Pokemon {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.height,
    required super.weight,
    required super.types,
    required super.abilities,
    required super.imageUrl,
    required super.stats,
  });

  /// Creates a PokemonModel from JSON data received from the API.
  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      imageUrl: json['sprites']['other']['official-artwork']['front_default']
              as String? ??
          json['sprites']['front_default'] as String? ??
          '',
      stats: {
        'hp': json['stats'][0]['base_stat'] as int,
        'attack': json['stats'][1]['base_stat'] as int,
        'defense': json['stats'][2]['base_stat'] as int,
        'special-attack': json['stats'][3]['base_stat'] as int,
        'special-defense': json['stats'][4]['base_stat'] as int,
        'speed': json['stats'][5]['base_stat'] as int,
      },
    );
  }

  /// Converts the PokemonModel to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'types': types,
      'abilities': abilities,
      'imageUrl': imageUrl,
      'stats': stats,
    };
  }
}
