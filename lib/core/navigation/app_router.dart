/// App router configuration using GoRouter
///
/// This file defines all the routes and navigation logic for the application.
/// It uses GoRouter for declarative routing and deep linking support.
library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/pokemon/presentation/cubit/cubit.dart';
import '../../features/pokemon/presentation/pages/pokemon_list/pokemon_list_page.dart';
import '../../features/pokemon/presentation/pages/pokemon_detail/pokemon_detail_page.dart';
import '../../injection_container.dart';
import '../presentation/pages/error_page.dart';

/// Router configuration for the application
class AppRouter {
  /// Creates the GoRouter instance with all route definitions
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => BlocProvider(
            create: (_) => sl<PokemonListCubit>(),
            child: const PokemonListPage(),
          ),
        ),
        GoRoute(
          path: '/pokemon/:id',
          name: 'pokemon-detail',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            final name = state.uri.queryParameters['name'] ?? '';
            final imageUrl = state.uri.queryParameters['imageUrl'];

            return BlocProvider(
              create: (_) => sl<PokemonDetailCubit>()..loadPokemonDetail(id),
              child: PokemonDetailPage(
                pokemonId: id,
                pokemonName: name,
                imageUrl: imageUrl,
              ),
            );
          },
        ),
      ],
      errorBuilder: (context, state) => ErrorPage(
        errorMessage: state.uri.toString(),
      ),
    );
  }
}
