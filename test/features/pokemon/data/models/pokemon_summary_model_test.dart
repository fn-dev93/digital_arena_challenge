import 'package:flutter_test/flutter_test.dart';
import 'package:digital_arena_challenge/features/pokemon/data/models/pokemon_summary_model.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/entities/pokemon_summary.dart';

void main() {
  const tPokemonSummaryModel = PokemonSummaryModel(
    id: 1,
    name: 'bulbasaur',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
  );

  group('PokemonSummaryModel', () {
    test('should be a subclass of PokemonSummary entity', () {
      // assert
      expect(tPokemonSummaryModel, isA<PokemonSummary>());
    });

    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'name': 'bulbasaur',
        'url': 'https://pokeapi.co/api/v2/pokemon/1/',
      };

      // act
      final result = PokemonSummaryModel.fromJson(jsonMap, 1);

      // assert
      expect(result, equals(tPokemonSummaryModel));
    });

    test('should return a JSON map containing proper data', () {
      // act
      final result = tPokemonSummaryModel.toJson();

      // assert
      final expectedMap = {
        'id': 1,
        'name': 'bulbasaur',
        'imageUrl':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
      };
      expect(result, equals(expectedMap));
    });
  });
}
