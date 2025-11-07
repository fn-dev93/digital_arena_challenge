import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/error.dart';
import '../models/models.dart';

/// Contract for Pokemon remote data source.
/// Defines methods for fetching Pokemon data from the API.
abstract class PokemonRemoteDataSource {
  Future<List<PokemonSummaryModel>> getPokemonList({
    required int limit,
    required int offset,
  });

  Future<PokemonModel> getPokemonDetail(int id);
}

/// Implementation of PokemonRemoteDataSource using HTTP client.
/// Fetches Pokemon data from PokeAPI.
class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PokemonSummaryModel>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final url = ApiConstants.getPokemonListUrl(limit: limit, offset: offset);
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final results = jsonData['results'] as List;

        return results.asMap().entries.map((entry) {
          final index = entry.key;
          final pokemon = entry.value;
          final id = offset + index + 1;
          return PokemonSummaryModel.fromJson(pokemon, id);
        }).toList();
      } else {
        throw ServerException(
            'Failed to load Pokemon list: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<PokemonModel> getPokemonDetail(int id) async {
    try {
      final url = ApiConstants.getPokemonUrl(id);
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return PokemonModel.fromJson(jsonData);
      } else {
        throw ServerException(
            'Failed to load Pokemon detail: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error: $e');
    }
  }
}
