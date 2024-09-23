import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/provider/provider.dart';

class PokemonListProvider extends StateNotifier<PokemonListModel?> {
  PokemonListProvider() : super(null);

  Future<void> getList(String url, WidgetRef ref) async {
    try {
      final response = await ref.watch(getPokemonLists).getPokemonList(url);
      if (response.count! > 0) {
        state = state?.copyWith(
              count: response.count,
              next: response.next,
              previous: response.previous,
              results: [...?state?.results, ...response.results!],
            ) ??
            response;
      }
    } catch (error) {
      print('Error fetching data list: $error');
    }
  }
}

final pokemonListProvider =
    StateNotifierProvider<PokemonListProvider, PokemonListModel?>((ref) {
  return PokemonListProvider();
});
