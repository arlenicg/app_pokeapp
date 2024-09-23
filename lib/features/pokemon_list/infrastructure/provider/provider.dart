import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/features/pokemon_list/domain/repository/pokemon_list_repository.dart';
import 'package:poke_app/features/pokemon_list/infrastructure/repository/pokemon_detail_repository_impl.dart';
import 'package:poke_app/features/pokemon_list/infrastructure/repository/pokemon_list_repository_impl.dart';
import 'package:poke_app/features/pokemon_list/infrastructure/repository/pokemon_species_list_repository_impl.dart';

final getPokemonList = Provider<PokemonListRepository>((ref) {
  return PokemonListRepositoryImpl();
});

final getPokemonSpeciesList = Provider<PokemonSpeciesListRepository>((ref) {
  return PokemonSpeciesListRepositoryImpl();
});

final getPokemonDetailList = Provider<PokemonDetailListRepository>((ref) {
  return PokemonDetailListRepositoryImpl();
});
