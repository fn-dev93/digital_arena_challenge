import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:digital_arena_challenge/core/constants/api_constants.dart';
import 'package:digital_arena_challenge/core/error/exceptions.dart';
import 'package:digital_arena_challenge/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:digital_arena_challenge/features/pokemon/data/models/pokemon_model.dart';
import 'package:digital_arena_challenge/features/pokemon/data/models/pokemon_summary_model.dart';
import '../../../../fixtures/json_reader.dart';

@GenerateMocks([http.Client])
import 'pokemon_remote_data_source_test.mocks.dart';

void main() {
  late PokemonRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = PokemonRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getPokemonList', () {
    final tPokemonSummaryList = [
      const PokemonSummaryModel(
        id: 1,
        name: 'bulbasaur',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
      ),
      const PokemonSummaryModel(
        id: 2,
        name: 'ivysaur',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png',
      ),
    ];

    test('should perform a GET request on a URL with limit and offset',
        () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(pokemonListJsonString, 200),
      );

      // act
      await dataSource.getPokemonList(limit: 20, offset: 0);

      // assert
      verify(mockHttpClient.get(
        Uri.parse(ApiConstants.getPokemonListUrl(limit: 20, offset: 0)),
      ),);
    });

    test('should return list of PokemonSummaryModel when response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(pokemonListJsonString, 200),
      );

      // act
      final result = await dataSource.getPokemonList(limit: 20, offset: 0);

      // assert
      expect(result, equals(tPokemonSummaryList));
    });

    test('should throw ServerException when response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('Something went wrong', 404),
      );

      // act
      final call = dataSource.getPokemonList;

      // assert
      expect(
        () => call(limit: 20, offset: 0),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw NetworkException when there is a network error',
        () async {
      // arrange
      when(mockHttpClient.get(any)).thenThrow(Exception('Network error'));

      // act
      final call = dataSource.getPokemonList;

      // assert
      expect(
        () => call(limit: 20, offset: 0),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('getPokemonDetail', () {
    const tId = 1;
    final tPokemonModel =
        PokemonModel.fromJson(json.decode(pokemonDetailJsonString));

    test('should perform a GET request on a URL with pokemon id', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(pokemonDetailJsonString, 200),
      );

      // act
      await dataSource.getPokemonDetail(tId);

      // assert
      verify(mockHttpClient.get(
        Uri.parse(ApiConstants.getPokemonUrl(tId)),
      ),);
    });

    test('should return PokemonModel when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(pokemonDetailJsonString, 200),
      );

      // act
      final result = await dataSource.getPokemonDetail(tId);

      // assert
      expect(result, equals(tPokemonModel));
    });

    test('should throw ServerException when response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('Not found', 404),
      );

      // act
      final call = dataSource.getPokemonDetail;

      // assert
      expect(
        () => call(tId),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw NetworkException when there is a network error',
        () async {
      // arrange
      when(mockHttpClient.get(any)).thenThrow(Exception('Network error'));

      // act
      final call = dataSource.getPokemonDetail;

      // assert
      expect(
        () => call(tId),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
