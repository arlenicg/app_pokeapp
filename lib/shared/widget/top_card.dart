import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/core/sytles/app_fonts.dart';
import 'package:poke_app/core/utils/conversiones.dart';
import 'package:poke_app/core/utils/get_color_name.dart';
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_detail_list_model.dart';
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_list_model.dart';
import 'package:poke_app/features/pokemon_list/presentation/viewmodel/pokemon_detail_list_provider.dart';
import 'package:poke_app/features/pokemon_list/presentation/viewmodel/pokemon_favorites_list_provider.dart';
import 'package:poke_app/features/pokemon_list/presentation/viewmodel/pokemon_species_list_provider.dart';

class TopCard extends ConsumerStatefulWidget {
  final Results? pokemon;

  const TopCard({Key? key, required this.pokemon}) : super(key: key);

  @override
  _TopCardState createState() => _TopCardState();
}

class _TopCardState extends ConsumerState<TopCard> {
  String? speciesColor;
  String? urlimg;
  List<Moves>? moves;
  List<Stats>? stats;
  int? height;
  int? weight;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.pokemon != null && _isLoading) {
      _fetchSpeciesColor();
      _fetchDetail();
    }
  }

  Future<void> _fetchSpeciesColor() async {
    await ref
        .read(pokemonSpeciesListProvider.notifier)
        .getList(widget.pokemon?.name, ref);
    final speciesData = ref.read(pokemonSpeciesListProvider);
    if (speciesData != null && speciesData.color != null) {
      setState(() {
        speciesColor =
            speciesData.color!.name; 
      });
    }
  }

  Future<void> _fetchDetail() async {
    await ref
        .read(pokemonDetaiListProvider.notifier)
        .getList(widget.pokemon?.url, ref);
    final detailData = ref.read(pokemonDetaiListProvider);
    setState(() {
      urlimg = detailData?.sprites?.frontDefault;
      moves = detailData?.moves?.take(8).toList() ?? [];
      stats = detailData?.stats;
      height = detailData?.height;
      weight = detailData?.weight;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite =
        ref.watch(favoritosProvider).contains(widget.pokemon?.name);

    return GridTile(
      footer: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.pokemon?.name?.capitalize() ?? '',
              style: AppFonts.titleCard.copyWith(color: Colors.white),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_circle_right_rounded,
                  color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
     header: Padding(
  padding: const EdgeInsets.only(left: 10, top: 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.white,
      ),
    ],
  ),
),

      child: InkWell(
        onTap: () {
          if (widget.pokemon != null) {
            context.go('/pokemon/${widget.pokemon!.name}', extra: {
              'moves': moves,
              'urlimg': urlimg,
              'stats': stats,
              'height': height,
              'weight': weight,
              'speciesColor': speciesColor,
            });
          }
        },
        child: Card(
          color: getColorName(speciesColor),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : urlimg != null
                      ? Hero(
                          tag: 'common_image_tag_${widget.pokemon!.name}',
                          child: Image.network(
                            urlimg!,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Text('Error al cargar imagen',
                                    style: TextStyle(color: Colors.white)),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Text('Imagen no disponible',
                              style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}
