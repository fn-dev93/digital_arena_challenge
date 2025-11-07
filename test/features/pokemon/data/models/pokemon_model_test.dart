import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:digital_arena_challenge/features/pokemon/data/models/pokemon_model.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/entities/pokemon.dart';
import '../../../../fixtures/json_reader.dart';

void main() {
  const tPokemonModel = PokemonModel(
    id: 1,
    name: 'bulbasaur',
    height: 7,
    weight: 69,
    types: ['grass', 'poison'],
    abilities: ['overgrow', 'chlorophyll'],
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
    stats: {
      'hp': 45,
      'attack': 49,
      'defense': 49,
      'special-attack': 65,
      'special-defense': 65,
      'speed': 45,
    },
  );

  group('PokemonModel', () {
    test('should be a subclass of Pokemon entity', () {
      // assert
      expect(tPokemonModel, isA<Pokemon>());
    });

    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(pokemonDetailJsonString);

      // act
      final result = PokemonModel.fromJson(jsonMap);

      // assert
      expect(result, equals(tPokemonModel));
    });

    test('should return a JSON map containing proper data', () {
      // act
      final result = tPokemonModel.toJson();

      // assert
      final expectedMap = {
        'id': 1,
        'name': 'bulbasaur',
        'height': 7,
        'weight': 69,
        'types': ['grass', 'poison'],
        'abilities': ['overgrow', 'chlorophyll'],
        'imageUrl':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
        'stats': {
          'hp': 45,
          'attack': 49,
          'defense': 49,
          'special-attack': 65,
          'special-defense': 65,
          'speed': 45,
        },
      };
      expect(result, equals(expectedMap));
    });
  });
}
