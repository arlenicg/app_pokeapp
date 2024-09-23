import 'package:dio/dio.dart';
import 'package:poke_app/core/network/dio_client.dart';
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_detail_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/repository/pokemon_list_repository.dart';

class PokemonDetailListRepositoryImpl implements PokemonDetailListRepository {
  @override
  Future<PokemonDetailListModel> getPokemonDetailList(String url) async {
    try {
      final response = await DioClient.instance.get(
        url,
      );
      //print(response);
      return PokemonDetailListModel.fromJson(response);
    } on DioException catch (e) {
      var error = e.toString();
      throw error;
    }
  }
}
