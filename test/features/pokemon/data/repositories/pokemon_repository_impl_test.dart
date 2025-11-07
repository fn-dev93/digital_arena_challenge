import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:digital_arena_challenge/core/error/exceptions.dart';
import 'package:digital_arena_challenge/core/error/failures.dart';
import 'package:digital_arena_challenge/core/network/network_info.dart';
import 'package:digital_arena_challenge/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:digital_arena_challenge/features/pokemon/data/models/pokemon_model.dart';
import 'package:digital_arena_challenge/features/pokemon/data/models/pokemon_summary_model.dart';
import 'package:digital_arena_challenge/features/pokemon/data/repositories/pokemon_repository_impl.dart';

@GenerateMocks([PokemonRemoteDataSource, NetworkInfo])
import 'pokemon_repository_impl_test.mocks.dart';

void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockPokemonRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PokemonRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getPokemonList', () {
    const tLimit = 20;
    const tOffset = 0;
    const tPokemonSummaryList = [
      PokemonSummaryModel(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/1.png',
      ),
    ];

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPokemonList(
        limit: anyNamed('limit'),
        offset: anyNamed('offset'),
      )).thenAnswer((_) async => tPokemonSummaryList);

      // act
      await repository.getPokemonList(limit: tLimit, offset: tOffset);

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonList(
          limit: anyNamed('limit'),
          offset: anyNamed('offset'),
        )).thenAnswer((_) async => tPokemonSummaryList);

        // act
        final result =
            await repository.getPokemonList(limit: tLimit, offset: tOffset);

        // assert
        verify(mockRemoteDataSource.getPokemonList(
            limit: tLimit, offset: tOffset));
        expect(result, equals(const Right(tPokemonSummaryList)));
      });

      test(
          'should return ServerFailure when remote data source throws ServerException',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonList(
          limit: anyNamed('limit'),
          offset: anyNamed('offset'),
        )).thenThrow(ServerException('Server error'));

        // act
        final result =
            await repository.getPokemonList(limit: tLimit, offset: tOffset);

        // assert
        verify(mockRemoteDataSource.getPokemonList(
            limit: tLimit, offset: tOffset));
        expect(result, equals(const Left(ServerFailure('Server error'))));
      });

      test(
          'should return NetworkFailure when remote data source throws NetworkException',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonList(
          limit: anyNamed('limit'),
          offset: anyNamed('offset'),
        )).thenThrow(NetworkException('Network error'));

        // act
        final result =
            await repository.getPokemonList(limit: tLimit, offset: tOffset);

        // assert
        expect(result, equals(const Left(NetworkFailure('Network error'))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return NetworkFailure when device is offline', () async {
        // act
        final result =
            await repository.getPokemonList(limit: tLimit, offset: tOffset);

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result,
            equals(const Left(NetworkFailure('No internet connection'))));
      });
    });
  });

  group('getPokemonDetail', () {
    const tId = 1;
    const tPokemonModel = PokemonModel(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      types: ['grass'],
      abilities: ['overgrow'],
      imageUrl: 'https://example.com/1.png',
      stats: {'hp': 45},
    );

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPokemonDetail(any))
          .thenAnswer((_) async => tPokemonModel);

      // act
      await repository.getPokemonDetail(tId);

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonDetail(any))
            .thenAnswer((_) async => tPokemonModel);

        // act
        final result = await repository.getPokemonDetail(tId);

        // assert
        verify(mockRemoteDataSource.getPokemonDetail(tId));
        expect(result, equals(const Right(tPokemonModel)));
      });

      test(
          'should return ServerFailure when remote data source throws ServerException',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonDetail(any))
            .thenThrow(ServerException('Server error'));

        // act
        final result = await repository.getPokemonDetail(tId);

        // assert
        expect(result, equals(const Left(ServerFailure('Server error'))));
      });

      test(
          'should return NetworkFailure when remote data source throws NetworkException',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonDetail(any))
            .thenThrow(NetworkException('Network error'));

        // act
        final result = await repository.getPokemonDetail(tId);

        // assert
        expect(result, equals(const Left(NetworkFailure('Network error'))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return NetworkFailure when device is offline', () async {
        // act
        final result = await repository.getPokemonDetail(tId);

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result,
            equals(const Left(NetworkFailure('No internet connection'))));
      });
    });
  });
}
