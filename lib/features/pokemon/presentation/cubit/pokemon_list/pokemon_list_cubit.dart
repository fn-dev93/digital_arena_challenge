import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import 'pokemon_list_state.dart';

/// Cubit for managing Pokemon list state.
/// Handles loading the initial list and pagination (infinite scroll).
class PokemonListCubit extends Cubit<PokemonListState> {
  final GetPokemonList getPokemonList;
  static const int _pokemonLimit = 20;

  PokemonListCubit({required this.getPokemonList})
      : super(PokemonListInitial());

  /// Loads the initial Pokemon list.
  Future<void> loadPokemonList() async {
    emit(PokemonListLoading());

    final result = await getPokemonList(
      const Params(limit: _pokemonLimit, offset: 0),
    );

    result.fold(
      (failure) => emit(PokemonListError(failure.message)),
      (pokemons) => emit(PokemonListLoaded(pokemons: pokemons)),
    );
  }

  /// Loads the next page of Pokemon (for infinite scroll).
  Future<void> loadMorePokemon() async {
    final currentState = state;
    if (currentState is! PokemonListLoaded || currentState.hasReachedMax) {
      return;
    }

    final result = await getPokemonList(
      Params(
        limit: _pokemonLimit,
        offset: currentState.pokemons.length,
      ),
    );

    result.fold(
      (failure) => emit(PokemonListError(failure.message)),
      (newPokemons) {
        if (newPokemons.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(currentState.copyWith(
            pokemons: List<PokemonSummary>.from(currentState.pokemons)
              ..addAll(newPokemons),
          ));
        }
      },
    );
  }
}
