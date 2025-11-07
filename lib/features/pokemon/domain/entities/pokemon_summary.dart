import 'package:equatable/equatable.dart';

/// Pokemon summary entity for list display.
/// Contains only the essential information needed for the Pokemon list.
class PokemonSummary extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  const PokemonSummary({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, imageUrl];
}
