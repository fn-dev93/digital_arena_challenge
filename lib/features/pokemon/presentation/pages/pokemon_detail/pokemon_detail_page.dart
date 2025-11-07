import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_arena_challenge/injection_container.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/utils/responsive.dart';
import '../../cubit/cubit.dart';
import '../../widgets/widgets.dart';

class PokemonDetailPage extends StatelessWidget {
  final int pokemonId;
  final String pokemonName;

  const PokemonDetailPage({
    super.key,
    required this.pokemonId,
    required this.pokemonName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PokemonDetailCubit>()..loadPokemonDetail(pokemonId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(pokemonName.toUpperCase()),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
          builder: (context, state) {
            if (state is PokemonDetailLoading) {
              return const LoadingIndicator();
            }

            if (state is PokemonDetailError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            if (state is PokemonDetailLoaded) {
              final pokemon = state.pokemon;
              return ResponsiveLayout(
                mobile: _PokemonDetailContent(pokemon: pokemon),
                tablet: _PokemonDetailContent(pokemon: pokemon, isTablet: true),
                desktop: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child:
                        _PokemonDetailContent(pokemon: pokemon, isTablet: true),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _PokemonDetailContent extends StatelessWidget {
  final dynamic pokemon;
  final bool isTablet;

  const _PokemonDetailContent({
    required this.pokemon,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final imageSize = context.responsive(
      mobile: 200.0,
      tablet: 250.0,
      desktop: 300.0,
    );
    final spacing = context.responsive(
      mobile: 8.0,
      tablet: 12.0,
      desktop: 16.0,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade400, Colors.red.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: spacing * 2.5),
                Hero(
                  tag: 'pokemon-${pokemon.id}',
                  child: Image.network(
                    pokemon.imageUrl,
                    height: imageSize,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.catching_pokemon,
                        size: imageSize,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
                SizedBox(height: spacing * 2.5),
              ],
            ),
          ),
          Padding(
            padding: ResponsivePadding.all(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '#${pokemon.id.toString().padLeft(3, '0')}',
                    style: TextStyle(
                      fontSize: ResponsiveFontSize.subtitle(context),
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: spacing),
                Center(
                  child: Wrap(
                    spacing: 8,
                    children: pokemon.types
                        .map<Widget>((type) => TypeBadge(type: type))
                        .toList(),
                  ),
                ),
                SizedBox(height: spacing * 3),
                Text(
                  l10n.physicalAttributes,
                  style: TextStyle(
                    fontSize: ResponsiveFontSize.title(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spacing * 1.5),
                Row(
                  children: [
                    Expanded(
                      child: _InfoCard(
                        icon: Icons.straighten,
                        label: l10n.height,
                        value: '${pokemon.height / 10} m',
                      ),
                    ),
                    SizedBox(width: spacing * 1.5),
                    Expanded(
                      child: _InfoCard(
                        icon: Icons.fitness_center,
                        label: l10n.weight,
                        value: '${pokemon.weight / 10} kg',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing * 3),
                Text(
                  l10n.abilities,
                  style: TextStyle(
                    fontSize: ResponsiveFontSize.title(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spacing * 1.5),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: pokemon.abilities
                      .map<Widget>((ability) => Chip(
                            label: Text(
                              ability.replaceAll('-', ' ').toUpperCase(),
                            ),
                            backgroundColor: Colors.grey[200],
                          ))
                      .toList(),
                ),
                SizedBox(height: spacing * 3),
                Text(
                  l10n.baseStats,
                  style: TextStyle(
                    fontSize: ResponsiveFontSize.title(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spacing * 1.5),
                PokemonStats(stats: pokemon.stats),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = context.responsive(
      mobile: 32.0,
      tablet: 40.0,
      desktop: 48.0,
    );
    final spacing = context.responsive(
      mobile: 8.0,
      tablet: 10.0,
      desktop: 12.0,
    );

    return Container(
      padding: ResponsivePadding.all(context),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: iconSize, color: Colors.red),
          SizedBox(height: spacing),
          Text(
            label,
            style: TextStyle(
              fontSize: ResponsiveFontSize.body(context),
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: spacing / 2),
          Text(
            value,
            style: TextStyle(
              fontSize: ResponsiveFontSize.subtitle(context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
