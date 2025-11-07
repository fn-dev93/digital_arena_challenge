import 'package:digital_arena_challenge/features/pokemon/domain/entities/pokemon.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/entities/pokemon_summary.dart';

const tPokemonSummary = PokemonSummary(
  id: 1,
  name: 'bulbasaur',
  imageUrl:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
);

const tPokemonSummaryList = [
  PokemonSummary(
    id: 1,
    name: 'bulbasaur',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
  ),
  PokemonSummary(
    id: 2,
    name: 'ivysaur',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png',
  ),
];

const tPokemon = Pokemon(
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
