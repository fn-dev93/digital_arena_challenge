import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/entities/pokemon.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/usecases/get_pokemon_detail.dart';

@GenerateMocks([PokemonRepository])
import 'get_pokemon_detail_test.mocks.dart';

void main() {
  late GetPokemonDetail usecase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    usecase = GetPokemonDetail(mockRepository);
  });

  const tId = 1;
  const tPokemon = Pokemon(
    id: 1,
    name: 'bulbasaur',
    height: 7,
    weight: 69,
    types: ['grass'],
    abilities: ['overgrow'],
    imageUrl: 'https://example.com/1.png',
    stats: {'hp': 45},
  );

  test('should get pokemon detail from the repository', () async {
    // arrange
    when(mockRepository.getPokemonDetail(any))
        .thenAnswer((_) async => const Right(tPokemon));

    // act
    final result = await usecase(tId);

    // assert
    expect(result, const Right(tPokemon));
    verify(mockRepository.getPokemonDetail(tId));
    verifyNoMoreInteractions(mockRepository);
  });
}
