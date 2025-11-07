import 'package:dartz/dartz.dart';
import '../../../../core/error/error.dart';
import '../entities/entities.dart';

/// Repository contract for Pokemon data operations.
/// Defines the interface that data layer must implement.
abstract class PokemonRepository {
  /// Get a paginated list of Pokemon.
  Future<Either<Failure, List<PokemonSummary>>> getPokemonList({
    required int limit,
    required int offset,
  });

  /// Get detailed information for a specific Pokemon by ID.
  Future<Either<Failure, Pokemon>> getPokemonDetail(int id);
}
