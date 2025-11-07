import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/error.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

/// Use case for retrieving a paginated list of Pokemon.
/// Encapsulates the business logic for fetching Pokemon list.
class GetPokemonList {
  final PokemonRepository repository;

  GetPokemonList(this.repository);

  Future<Either<Failure, List<PokemonSummary>>> call(Params params) async {
    return await repository.getPokemonList(
      limit: params.limit,
      offset: params.offset,
    );
  }
}

/// Parameters for GetPokemonList use case.
class Params extends Equatable {
  final int limit;
  final int offset;

  const Params({
    required this.limit,
    required this.offset,
  });

  @override
  List<Object> get props => [limit, offset];
}
