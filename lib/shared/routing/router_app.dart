import 'package:go_router/go_router.dart';
import 'package:poke_app/features/pokemon_detail/presentation/pokemon_detail_screen.dart';

import '../../features/pokemon_list/presentation/screen/home_screen.dart';

class RouterApp {
  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: 'pokemon/:name',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final name = state.pathParameters['name'];

              return PokemonDetailScreen(
                pokemonName: name!,
                moves: extra?['moves'],
                urlimg: extra?['urlimg'],
                stats: extra?['stats'],
                height: extra?['height'],
                weight: extra?['weight'],
                speciesColor: extra?['speciesColor'],
              );
            },
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
