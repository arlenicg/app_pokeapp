import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_species_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/provider/provider.dart';

class PokemonSpeciesListProvider
    extends StateNotifier<PokemonSpeciesListModel?> {
  PokemonSpeciesListProvider() : super(null);

  Future<void> getList(String? nombre, WidgetRef ref) async {
    try {
      final response = await ref
          .watch(getPokemonSpeciesLists)
          .getPokemonSpeciesList(nombre!);
      if (response.id! > 0) {
        state = response;
      }
    } catch (error) {
     
    }
  }
}

final pokemonSpeciesListProvider =
    StateNotifierProvider<PokemonSpeciesListProvider, PokemonSpeciesListModel?>(
        (ref) {
  return PokemonSpeciesListProvider();
});
