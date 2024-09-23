import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_detail_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/provider/provider.dart';

class PokemonDetailListProvider extends StateNotifier<PokemonDetailListModel?> {
  PokemonDetailListProvider() : super(null);

  Future<void> getList(String? url, WidgetRef ref) async {
    try {
      final response =
          await ref.watch(getPokemonDetailLists).getPokemonDetailList(url!);
      if (response.id! > 0) {
        state = response;
      }
    } catch (error) {
      //print('Error fetching data pokemondetail: $error');
    }
  }
}

final pokemonDetaiListProvider =
    StateNotifierProvider<PokemonDetailListProvider, PokemonDetailListModel?>(
        (ref) {
  return PokemonDetailListProvider();
});
