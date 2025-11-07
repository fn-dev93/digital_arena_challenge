import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../cubit/cubit.dart';
import '../../widgets/widgets.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<PokemonListCubit>().loadPokemonList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PokemonListCubit>().loadMorePokemon();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pokedex),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
        builder: (context, state) {
          if (state is PokemonListLoading) {
            return const LoadingIndicator();
          }

          if (state is PokemonListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PokemonListCubit>().loadPokemonList();
                    },
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            );
          }

          if (state is PokemonListLoaded) {
            return GridView.builder(
              controller: _scrollController,
              padding: ResponsivePadding.all(context),
              gridDelegate: ResponsiveGridDelegate(
                context: context,
                mobileColumns: 2,
                tabletColumns: 3,
                desktopColumns: 4,
                largeDesktopColumns: 6,
                childAspectRatio: 0.85,
                crossAxisSpacing: context.responsive(
                  mobile: 12.0,
                  tablet: 16.0,
                  desktop: 20.0,
                ),
                mainAxisSpacing: context.responsive(
                  mobile: 12.0,
                  tablet: 16.0,
                  desktop: 20.0,
                ),
              ),
              itemCount: state.hasReachedMax
                  ? state.pokemons.length
                  : state.pokemons.length + 2,
              itemBuilder: (context, index) {
                if (index >= state.pokemons.length) {
                  return const Center(
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: LoadingIndicator(),
                    ),
                  );
                }

                final pokemon = state.pokemons[index];
                return PokemonCard(
                  pokemon: pokemon,
                  onTap: () =>
                      context.go('/pokemon/${pokemon.id}?name=${pokemon.name}'),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
