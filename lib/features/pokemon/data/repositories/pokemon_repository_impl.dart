import 'package:dartz/dartz.dart';
import '../../../../core/error/error.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';

/// Implementation of PokemonRepository.
/// Handles data fetching from remote source with network checking and error handling.
class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PokemonSummary>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final pokemonList = await remoteDataSource.getPokemonList(
          limit: limit,
          offset: offset,
        );
        return Right(pokemonList);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonDetail(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final pokemon = await remoteDataSource.getPokemonDetail(id);
        return Right(pokemon);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
