import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/core/network/paths.dart';
import 'package:poke_app/features/pokemon_list/presentation/viewmodel/pokemon_list_provider.dart';
import 'package:poke_app/shared/widget/skeleton_loader.dart';
import 'package:poke_app/shared/widget/top_card.dart';

class TopList extends ConsumerStatefulWidget {
 
  final bool isModalOpen;

  const TopList({
    Key? key,
    
    required this.isModalOpen,
  }) : super(key: key);

  @override
  _TopListState createState() => _TopListState();
}

class _TopListState extends ConsumerState<TopList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent * 1 !=
            _scrollController.position.outOfRange &&
        !widget.isModalOpen) {
      _loadMore();
    }
  }

  void _loadMore() {
    final currentList = ref.read(pokemonListProvider);

    if (currentList != null &&
        currentList.next != null &&
        currentList.results!.length < currentList.count!) {
      ref.read(pokemonListProvider.notifier).getList(currentList.next!, ref);
    } else {
      print('No hay más elementos para cargar.');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (ref.read(pokemonListProvider) == null ) {
      ref.read(pokemonListProvider.notifier).getList(urlFirst, ref);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonList = ref.watch(pokemonListProvider);

    return pokemonList == null
        ? SkeletonLoader()
        : GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemCount: pokemonList.results?.length ?? 0,
            itemBuilder: (context, index) {
              final pokemon = pokemonList.results?[index];
              return TopCard(pokemon: pokemon);
            },
          );
  }
}
