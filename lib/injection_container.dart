import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'core/network/network_info.dart';
import 'features/pokemon/data/datasources/datasources.dart';
import 'features/pokemon/data/repositories/repositories.dart';
import 'features/pokemon/domain/repositories/repositories.dart';
import 'features/pokemon/domain/usecases/usecases.dart';
import 'features/pokemon/presentation/cubit/cubit.dart';

/// Service locator instance for dependency injection.
final sl = GetIt.instance;

/// Initializes all dependencies using GetIt.
/// Call this before running the app.
Future<void> init() async {
  // Cubit - State management
  sl.registerFactory(
    () => PokemonListCubit(getPokemonList: sl()),
  );

  sl.registerFactory(
    () => PokemonDetailCubit(getPokemonDetail: sl()),
  );

  // Use cases - Business logic
  sl.registerLazySingleton(() => GetPokemonList(sl()));
  sl.registerLazySingleton(() => GetPokemonDetail(sl()));

  // Repository - Data abstraction layer
  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources - Remote data fetching
  sl.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(client: sl()),
  );

  // Core - Infrastructure
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // External - Third-party packages
  sl.registerLazySingleton(() => http.Client());
}
