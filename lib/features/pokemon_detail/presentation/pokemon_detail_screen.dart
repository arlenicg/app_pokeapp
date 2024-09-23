import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/core/sytles/app_colors.dart';
import 'package:poke_app/core/sytles/app_fonts.dart';
import 'package:poke_app/core/utils/app_localizations.dart';
import 'package:poke_app/core/utils/conversiones.dart';
import 'package:poke_app/core/utils/get_color_name.dart';
import 'package:poke_app/features/pokemon_list/domain/model/pokemon_detail_list_model.dart';
import 'package:poke_app/features/pokemon_list/presentation/viewmodel/pokemon_favorites_list_provider.dart';

class PokemonDetailScreen extends ConsumerStatefulWidget {
  final String pokemonName;
  final List<Moves>? moves;
  final String? urlimg;
  final List<Stats>? stats;
  final int? height;
  final int? weight;
  final String? speciesColor;

  const PokemonDetailScreen({
    super.key,
    required this.pokemonName,
    this.moves,
    this.urlimg,
    this.stats,
    this.height,
    this.weight,
    this.speciesColor,
  });

  @override
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends ConsumerState<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final favoritesNotifier = ref.watch(favoritosProvider.notifier);
    final isFavorite =
        ref.watch(favoritosProvider).contains(widget.pokemonName);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.pokemonName.capitalize(),
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => _toggleFavorite(context, favoritesNotifier),
          ),
        ],
      ),
  body: Padding(
  padding: const EdgeInsets.all(12.0), 
  child: Column(
    children: [
      _buildImageCard(),
      const SizedBox(height: 10),
      _buildInfoTable(),
      _buildTabs(),
    ],
  ),
),

    );
  }

  void _toggleFavorite(
      BuildContext context, FavoritosProvider favoritesNotifier) async {
    final isCurrentlyFavorite =
        favoritesNotifier.isFavorite(widget.pokemonName);
    final actionMessage = isCurrentlyFavorite
        ? '¿Deseas desmarcar como favorito?'
        : '¿Deseas marcar como favorito?';

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: Text(actionMessage),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No')),
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Sí')),
          ],
        );
      },
    );

    if (confirm == true) {
      await favoritesNotifier.toggleFavorite(widget.pokemonName);
    }
  }
Widget _buildImageCard() {
  return SizedBox(
    height: 300,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColors.backgroundCard,
      child: Center(
        child: widget.urlimg != null
            ? Image.network(
                widget.urlimg!,
                fit: BoxFit.fill, 
                width: double.infinity,
                height: double.infinity, 
              )
            : const SizedBox.shrink(),
      ),
    ),
  );
}



  Widget _buildInfoTable() {
    return Table(
      children: [
        TableRow(
          children: [
            _buildHeightColumn(),
            _buildIconColumn(),
            _buildWeightColumn(),
          ],
        ),
      ],
    );
  }

  Widget _buildHeightColumn() {
    return Column(
      children: [
        Text('${dmtom(widget.height ?? 0)} M', style: AppFonts.titleText),
        Text(AppLocalizations.of(context).translate("title_height") ?? "",
            style: AppFonts.subText),
      ],
    );
  }

  Widget _buildIconColumn() {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.iconBackground,
          child: ClipOval(
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/game_icon.png',
                height: 40,
                width: 40,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeightColumn() {
    return Column(
      children: [
        Text('${hgtokg(widget.weight ?? 0)} KG', style: AppFonts.titleText),
        Text(AppLocalizations.of(context).translate("title_weight") ?? "",
            style: AppFonts.subText),
      ],
    );
  }

  Widget _buildTabs() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                  text: AppLocalizations.of(context).translate("title_stats") ??
                      ""),
              Tab(
                  text: AppLocalizations.of(context).translate("title_moves") ??
                      ""),
            ],
            labelColor: AppColors.textTitle,
            unselectedLabelColor: AppColors.textTab,
            labelStyle: AppFonts.titleTab,
            indicatorColor: Colors.white,
          ),
          SizedBox(
            height: 200,
            child: TabBarView(
              children: [
                _buildStatsTable(),
                _buildMovesList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsTable() {
    return ListView.builder(
      itemCount: widget.stats?.length ?? 0,
      itemBuilder: (context, index) {
        final stat = widget.stats![index];
        final color = getColorName(widget.speciesColor);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(stat.stat!.name!.capitalize(), style: AppFonts.titlestat),
            ),
            Expanded(
              flex: 1,
              child: Text(
                stat.baseStat.toString(),
                style: TextStyle(
                    color: color, fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.textTab,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    minHeight: 10,
                    value: stat.baseStat! / 100,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMovesList() {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(14, 16, 32, 0.886),
                Color.fromRGBO(26, 25, 25, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children:
                  List<Widget>.generate(widget.moves?.length ?? 0, (index) {
                final move = widget.moves![index];
                return Chip(
                  label: Text(move.move!.name!.capitalize(), style: AppFonts.titleTag),
                  backgroundColor: const Color.fromARGB(255, 84, 84, 84),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(width: 0.0),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
