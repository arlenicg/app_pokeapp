
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_detail_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_species_list_model.dart';

abstract class PokemonListRepository{
  Future<PokemonListModel>getPokemonList(String url);
}

abstract class PokemonSpeciesListRepository{
  Future<PokemonSpeciesListModel>getPokemonSpeciesList(String nombre);
}

abstract class PokemonDetailListRepository{
  Future<PokemonDetailListModel>getPokemonDetailList(String url);
}

