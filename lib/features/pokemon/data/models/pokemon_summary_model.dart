import '../../domain/entities/entities.dart';

/// Data model for Pokemon summary that extends the domain entity.
/// Handles JSON serialization for list items.
class PokemonSummaryModel extends PokemonSummary {
  const PokemonSummaryModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  /// Creates a PokemonSummaryModel from JSON data.
  /// The ID is calculated from the offset since the API doesn't include it.
  factory PokemonSummaryModel.fromJson(Map<String, dynamic> json, int id) {
    return PokemonSummaryModel(
      id: id,
      name: json['name'] as String,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }

  /// Converts the PokemonSummaryModel to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
