import 'package:dio/dio.dart';
import 'package:poke_app/core/network/dio_client.dart';
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/repository/pokemon_list_repository.dart';

class PokemonListRepositoryImpl implements PokemonListRepository {
  @override
  Future<PokemonListModel> getPokemonList(String url) async {
    try {
      final response = await DioClient.instance.get(
        url,
      );
      //print(response);
      return PokemonListModel.fromJson(response);
    } on DioException catch (e) {
      var error = e.toString();
      throw error;
    }
  }
}
