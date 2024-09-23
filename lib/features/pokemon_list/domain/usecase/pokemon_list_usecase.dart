import 'package:poke_app/features/pokemon_list/domain/model/pokemon_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/repository/pokemon_list_repository.dart';

abstract class PokemonListUsecase {
  Future<PokemonListModel> getPokemonList(String url);
}

class PokemonListUsecaseImpl extends PokemonListUsecase {
  final PokemonListRepository pokemonListRepository;

  PokemonListUsecaseImpl(this.pokemonListRepository);

  @override
  Future<PokemonListModel> getPokemonList(String url) async {
    return await pokemonListRepository.getPokemonList(url);
  }
}
