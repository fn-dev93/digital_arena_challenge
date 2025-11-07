import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_arena_challenge/injection_container.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/utils/responsive.dart';
import '../../cubit/cubit.dart';
import '../../widgets/widgets.dart';

class PokemonDetailPage extends StatefulWidget {
  final int pokemonId;
  final String pokemonName;
  final String? imageUrl;

  const PokemonDetailPage({
    required this.pokemonId,
    required this.pokemonName,
    this.imageUrl,
    super.key,
  });

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late int currentPokemonId;
  late PokemonDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    currentPokemonId = widget.pokemonId;
    _cubit = sl<PokemonDetailCubit>()..loadPokemonDetail(currentPokemonId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _navigateToPokemon(int newId) {
    setState(() => currentPokemonId = newId);
    _cubit.loadPokemonDetail(newId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
        builder: (context, state) {
          final name = state is PokemonDetailLoaded ? state.pokemon.name : '';
          return Scaffold(
            appBar: AppBar(
              title: Text(name.toUpperCase()),
              centerTitle: true,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            body: GestureDetector(
              onHorizontalDragEnd: (details) {
                // Swipe right (previous pokemon)
                if (details.primaryVelocity! > 0 && currentPokemonId > 1) {
                  _navigateToPokemon(currentPokemonId - 1);
                }
                // Swipe left (next pokemon)
                else if (details.primaryVelocity! < 0) {
                  _navigateToPokemon(currentPokemonId + 1);
                }
              },
              child: Builder(
                builder: (context) {
                  if (state is PokemonDetailLoading) {
                    final imageSize = context.responsive(
                      mobile: 200.0,
                      tablet: 250.0,
                      desktop: 300.0,
                    );

                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red.shade400,
                                  Colors.red.shade700,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: ResponsivePadding.all(context).top,
                                ),
                                if (state is PokemonDetailLoaded)
                                  Hero(
                                    tag: 'pokemon-$currentPokemonId',
                                    child: Image.network(
                                      (state as PokemonDetailLoaded)
                                          .pokemon
                                          .imageUrl,
                                      height: imageSize,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(
                                          Icons.catching_pokemon,
                                          size: imageSize,
                                          color: Colors.white,
                                        );
                                      },
                                    ),
                                  )
                                else
                                  Icon(
                                    Icons.catching_pokemon,
                                    size: imageSize,
                                    color: Colors.white,
                                  ),
                                SizedBox(
                                  height: ResponsivePadding.all(context).bottom,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.all(32.0),
                          sliver: SliverToBoxAdapter(
                            child: LoadingIndicator(),
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is PokemonDetailError) {
                    return const _PokemonDetailError();
                  }

                  if (state is PokemonDetailLoaded) {
                    final pokemon = state.pokemon;
                    return ResponsiveLayout(
                      mobile: _PokemonDetailContent(
                        pokemon: pokemon,
                        onNavigate: _navigateToPokemon,
                      ),
                      tablet: _PokemonDetailContent(
                        pokemon: pokemon,
                        onNavigate: _navigateToPokemon,
                        isTablet: true,
                      ),
                      desktop: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 800),
                          child: _PokemonDetailContent(
                            pokemon: pokemon,
                            onNavigate: _navigateToPokemon,
                            isTablet: true,
                          ),
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PokemonDetailError extends StatelessWidget {
  const _PokemonDetailError();

  @override
  Widget build(BuildContext context) {
    final state =
        context.read<PokemonDetailCubit>().state as PokemonDetailError;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
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
}

class _PokemonDetailContent extends StatelessWidget {
  final dynamic pokemon;
  final bool isTablet;
  final Function(int) onNavigate;

  const _PokemonDetailContent({
    required this.pokemon,
    required this.onNavigate,
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

    return CustomScrollView(
      slivers: [
        // Header with gradient and image
        SliverToBoxAdapter(
          child: Container(
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
                // Image with navigation arrows
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      color: Colors.white,
                      iconSize: 40,
                      onPressed: pokemon.id > 1
                          ? () => onNavigate(pokemon.id - 1)
                          : null,
                    ),
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
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      color: Colors.white,
                      iconSize: 40,
                      onPressed: () => onNavigate(pokemon.id + 1),
                    ),
                  ],
                ),
                SizedBox(height: spacing * 2.5),
              ],
            ),
          ),
        ),
        // Content
        SliverPadding(
          padding: ResponsivePadding.all(context),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
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
                    .map<Widget>(
                      (ability) => Chip(
                        label: Text(
                          ability.replaceAll('-', ' ').toUpperCase(),
                        ),
                        backgroundColor: Colors.grey[200],
                      ),
                    )
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
            ]),
          ),
        ),
      ],
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
