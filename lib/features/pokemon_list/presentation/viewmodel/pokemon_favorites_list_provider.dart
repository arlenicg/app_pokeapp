import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosProvider extends StateNotifier<List<String>> {
  FavoritosProvider() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favoritos') ?? [];
    state = favorites;
  }

  Future<void> toggleFavorite(String name) async {
    final isFavorite = state.contains(name);

    if (isFavorite) {
      state = [...state]..remove(name);
    } else {
      state = [...state, name];
    }

    await _saveFavorites();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoritos', state);
  }

  bool isFavorite(String name) {
    return state.contains(name);
  }
}

final favoritosProvider =
    StateNotifierProvider<FavoritosProvider, List<String>>((ref) {
  return FavoritosProvider();
});
