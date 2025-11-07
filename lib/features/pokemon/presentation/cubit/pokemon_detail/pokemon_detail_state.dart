import 'package:equatable/equatable.dart';
import '../../../domain/entities/entities.dart';

/// Base state for Pokemon detail.
abstract class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any Pokemon detail is loaded.
class PokemonDetailInitial extends PokemonDetailState {}

/// State while loading Pokemon detail.
class PokemonDetailLoading extends PokemonDetailState {}

/// State when Pokemon detail is successfully loaded.
class PokemonDetailLoaded extends PokemonDetailState {
  final Pokemon pokemon;

  const PokemonDetailLoaded(this.pokemon);

  @override
  List<Object?> get props => [pokemon];
}

/// State when an error occurs while loading Pokemon detail.
class PokemonDetailError extends PokemonDetailState {
  final String message;

  const PokemonDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
