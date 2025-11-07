import 'package:equatable/equatable.dart';
import '../../../domain/entities/entities.dart';

/// Base state for Pokemon list.
abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any data is loaded.
class PokemonListInitial extends PokemonListState {}

/// State while loading the first page.
class PokemonListLoading extends PokemonListState {}

/// State when Pokemon list is successfully loaded.
class PokemonListLoaded extends PokemonListState {
  final List<PokemonSummary> pokemons;
  final bool hasReachedMax;

  const PokemonListLoaded({
    required this.pokemons,
    this.hasReachedMax = false,
  });

  PokemonListLoaded copyWith({
    List<PokemonSummary>? pokemons,
    bool? hasReachedMax,
  }) {
    return PokemonListLoaded(
      pokemons: pokemons ?? this.pokemons,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [pokemons, hasReachedMax];
}

/// State when an error occurs while loading Pokemon.
class PokemonListError extends PokemonListState {
  final String message;

  const PokemonListError(this.message);

  @override
  List<Object?> get props => [message];
}
