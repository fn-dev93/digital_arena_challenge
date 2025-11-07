import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/entities/pokemon_summary.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/usecases/get_pokemon_list.dart';

@GenerateMocks([PokemonRepository])
import 'get_pokemon_list_test.mocks.dart';

void main() {
  late GetPokemonList usecase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    usecase = GetPokemonList(mockRepository);
  });

  const tPokemonList = [
    PokemonSummary(
      id: 1,
      name: 'bulbasaur',
      imageUrl: 'https://example.com/1.png',
    ),
  ];
  const tLimit = 20;
  const tOffset = 0;

  test('should get pokemon list from the repository', () async {
    // arrange
    when(mockRepository.getPokemonList(
      limit: anyNamed('limit'),
      offset: anyNamed('offset'),
    )).thenAnswer((_) async => const Right(tPokemonList));

    // act
    final result = await usecase(const Params(limit: tLimit, offset: tOffset));

    // assert
    expect(result, const Right(tPokemonList));
    verify(mockRepository.getPokemonList(limit: tLimit, offset: tOffset));
    verifyNoMoreInteractions(mockRepository);
  });
}
