import 'package:poke_app/features/pokemon_list/domain/model/pokemon_species_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/repository/pokemon_list_repository.dart';

abstract class PokemonSpeciesListUsecase {
  Future<PokemonSpeciesListModel> getPokemonSpeciesList(String nombre);
}

class PokemonSpeciesListUsecaseImpl extends PokemonSpeciesListUsecase {
  final PokemonSpeciesListRepository pokemonSpeciesListRepository;

  PokemonSpeciesListUsecaseImpl(this.pokemonSpeciesListRepository);

  @override
  Future<PokemonSpeciesListModel> getPokemonSpeciesList(String nombre) async {
    return await pokemonSpeciesListRepository.getPokemonSpeciesList(nombre);
  }
}
