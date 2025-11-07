import 'package:dartz/dartz.dart';
import '../../../../core/error/error.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

/// Use case for retrieving detailed Pokemon information.
/// Encapsulates the business logic for fetching a single Pokemon's details.
class GetPokemonDetail {
  final PokemonRepository repository;

  GetPokemonDetail(this.repository);

  Future<Either<Failure, Pokemon>> call(int id) async {
    return await repository.getPokemonDetail(id);
  }
}
