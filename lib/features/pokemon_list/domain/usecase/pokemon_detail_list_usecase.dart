import 'package:poke_app/features/pokemon_list/domain/model/pokemon_detail_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/repository/pokemon_list_repository.dart';

abstract class PokemonDetailListUsecase {
  Future<PokemonDetailListModel> getPokemonDetailList(String url);
}

class PokemonDetailListUsecaseImpl extends PokemonDetailListUsecase {
  final PokemonDetailListRepository pokemonDetailListRepository;

  PokemonDetailListUsecaseImpl(this.pokemonDetailListRepository);

  @override
  Future<PokemonDetailListModel> getPokemonDetailList(String url) async {
    return await pokemonDetailListRepository.getPokemonDetailList(url);
  }
}
