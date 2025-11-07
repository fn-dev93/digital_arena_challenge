import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:digital_arena_challenge/core/error/failures.dart';
import 'package:digital_arena_challenge/features/pokemon/domain/usecases/get_pokemon_detail.dart';
import 'package:digital_arena_challenge/features/pokemon/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:digital_arena_challenge/features/pokemon/presentation/cubit/pokemon_detail/pokemon_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/pokemon_fixtures.dart';
import 'pokemon_detail_cubit_test.mocks.dart';

@GenerateMocks([GetPokemonDetail])
void main() {
  late PokemonDetailCubit cubit;
  late MockGetPokemonDetail mockGetPokemonDetail;

  setUp(() {
    mockGetPokemonDetail = MockGetPokemonDetail();
    cubit = PokemonDetailCubit(getPokemonDetail: mockGetPokemonDetail);
  });

  const tPokemonId = 1;

  group('PokemonDetailCubit', () {
    test('initial state should be PokemonDetailInitial', () {
      expect(cubit.state, equals(PokemonDetailInitial()));
    });

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPokemonDetail(any))
            .thenAnswer((_) async => const Right(tPokemon));
        return cubit;
      },
      act: (cubit) => cubit.loadPokemonDetail(tPokemonId),
      expect: () => [
        PokemonDetailLoading(),
        const PokemonDetailLoaded(tPokemon),
      ],
    );

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockGetPokemonDetail(any))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return cubit;
      },
      act: (cubit) => cubit.loadPokemonDetail(tPokemonId),
      expect: () => [
        PokemonDetailLoading(),
        const PokemonDetailError('Server Failure'),
      ],
    );

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should emit Error with cache failure message when cache fails',
      build: () {
        when(mockGetPokemonDetail(any))
            .thenAnswer((_) async => const Left(CacheFailure('Cache Failure')));
        return cubit;
      },
      act: (cubit) => cubit.loadPokemonDetail(tPokemonId),
      expect: () => [
        PokemonDetailLoading(),
        const PokemonDetailError('Cache Failure'),
      ],
    );

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should emit Error with network failure message when network fails',
      build: () {
        when(mockGetPokemonDetail(any))
            .thenAnswer((_) async => const Left(NetworkFailure('Network Failure')));
        return cubit;
      },
      act: (cubit) => cubit.loadPokemonDetail(tPokemonId),
      expect: () => [
        PokemonDetailLoading(),
        const PokemonDetailError('Network Failure'),
      ],
    );
  });
}
