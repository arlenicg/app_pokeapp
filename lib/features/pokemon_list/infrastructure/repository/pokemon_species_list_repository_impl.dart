import 'package:dio/dio.dart';
import 'package:poke_app/core/network/dio_client.dart';
import 'package:poke_app/core/network/paths.dart';
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_species_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/repository/pokemon_list_repository.dart';

class PokemonSpeciesListRepositoryImpl implements PokemonSpeciesListRepository {
  @override
  Future<PokemonSpeciesListModel> getPokemonSpeciesList(String nombre) async {
    try {
      final response = await DioClient.instance.get(
        '$pokemonspecies$nombre',
      );

      //print(response);
      return PokemonSpeciesListModel.fromJson(response);
    } on DioException catch (e) {
      var error = e.toString();
      throw error;
    }
  }
}
