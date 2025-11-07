/// Constants for PokeAPI endpoints.
class ApiConstants {
  static const String baseUrl = 'https://pokeapi.co/api/v2';
  static const String pokemonEndpoint = '/pokemon';
  static const String pokemonSpeciesEndpoint = '/pokemon-species';

  /// Returns the URL for a specific Pokemon by ID.
  static String getPokemonUrl(int id) => '$baseUrl$pokemonEndpoint/$id';

  /// Returns the URL for the Pokemon list with pagination.
  static String getPokemonListUrl({int limit = 20, int offset = 0}) =>
      '$baseUrl$pokemonEndpoint?limit=$limit&offset=$offset';
}
