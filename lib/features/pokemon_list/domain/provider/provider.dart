
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/features/pokemon_list/domain/usecase/pokemon_detail_list_usecase.dart';
import 'package:poke_app/features/pokemon_list/domain/usecase/pokemon_list_usecase.dart';

import 'package:poke_app/features/pokemon_list/domain/usecase/pokemon_species_list_usecase.dart';
import 'package:poke_app/features/pokemon_list/infrastructure/provider/provider.dart';


final getPokemonLists = Provider<PokemonListUsecase>((ref){

  return PokemonListUsecaseImpl(ref.read(getPokemonList));
});


final getPokemonSpeciesLists = Provider<PokemonSpeciesListUsecase>((ref){

  return PokemonSpeciesListUsecaseImpl(ref.read(getPokemonSpeciesList));
});


final getPokemonDetailLists = Provider<PokemonDetailListUsecase>((ref){

  return PokemonDetailListUsecaseImpl(ref.read(getPokemonDetailList));
});


