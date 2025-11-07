import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/usecases.dart';
import 'pokemon_detail_state.dart';

/// Cubit for managing Pokemon detail state.
/// Handles loading detailed information for a specific Pokemon.
class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final GetPokemonDetail getPokemonDetail;

  PokemonDetailCubit({required this.getPokemonDetail})
      : super(PokemonDetailInitial());

  /// Loads detailed information for a Pokemon by ID.
  Future<void> loadPokemonDetail(int pokemonId) async {
    emit(PokemonDetailLoading());

    final result = await getPokemonDetail(pokemonId);

    result.fold(
      (failure) => emit(PokemonDetailError(failure.message)),
      (pokemon) => emit(PokemonDetailLoaded(pokemon)),
    );
  }
}
