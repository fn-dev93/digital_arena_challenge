import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:digital_arena_challenge/core/error/failures.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/entities/pokemon_summary.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'package:digital_arena_challenge/features/pokemon/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';
import 'package:digital_arena_challenge/features/pokemon/presentation/cubit/pokemon_list/pokemon_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/pokemon_fixtures.dart';
import 'pokemon_list_cubit_test.mocks.dart';

@GenerateMocks([GetPokemonList])
void main() {
  late PokemonListCubit cubit;
  late MockGetPokemonList mockGetPokemonList;

  setUp(() {
    mockGetPokemonList = MockGetPokemonList();
    cubit = PokemonListCubit(getPokemonList: mockGetPokemonList);
  });

  group('PokemonListCubit', () {
    test('initial state should be PokemonListInitial', () {
      expect(cubit.state, equals(PokemonListInitial()));
    });

    blocTest<PokemonListCubit, PokemonListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPokemonList(any))
            .thenAnswer((_) async => Right(tPokemonSummaryList));
        return cubit;
      },
      act: (cubit) => cubit.loadPokemonList(),
      expect: () => [
        PokemonListLoading(),
        PokemonListLoaded(pokemons: tPokemonSummaryList),
      ],
    );

    blocTest<PokemonListCubit, PokemonListState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockGetPokemonList(any))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return cubit;
      },
      act: (cubit) => cubit.loadPokemonList(),
      expect: () => [
        PokemonListLoading(),
        const PokemonListError('Server Failure'),
      ],
    );

    blocTest<PokemonListCubit, PokemonListState>(
      'should load more pokemon when loadMorePokemon is called',
      build: () {
        when(mockGetPokemonList(any))
            .thenAnswer((_) async => Right(tPokemonSummaryList));
        return cubit;
      },
      seed: () => PokemonListLoaded(pokemons: tPokemonSummaryList),
      act: (cubit) => cubit.loadMorePokemon(),
      expect: () => [
        PokemonListLoaded(
          pokemons: [...tPokemonSummaryList, ...tPokemonSummaryList],
        ),
      ],
    );

    blocTest<PokemonListCubit, PokemonListState>(
      'should set hasReachedMax when no more pokemon are available',
      build: () {
        when(mockGetPokemonList(any))
            .thenAnswer((_) async => const Right(<PokemonSummary>[]));
        return cubit;
      },
      seed: () => PokemonListLoaded(pokemons: tPokemonSummaryList),
      act: (cubit) => cubit.loadMorePokemon(),
      expect: () => [
        PokemonListLoaded(
          pokemons: tPokemonSummaryList,
          hasReachedMax: true,
        ),
      ],
    );

    blocTest<PokemonListCubit, PokemonListState>(
      'should not load more when hasReachedMax is true',
      build: () {
        return cubit;
      },
      seed: () => PokemonListLoaded(
        pokemons: tPokemonSummaryList,
        hasReachedMax: true,
      ),
      act: (cubit) => cubit.loadMorePokemon(),
      expect: () => [],
    );

    blocTest<PokemonListCubit, PokemonListState>(
      'should not load more when state is not PokemonListLoaded',
      build: () {
        return cubit;
      },
      act: (cubit) => cubit.loadMorePokemon(),
      expect: () => [],
    );
  });
}
