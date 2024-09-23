import 'package:flutter/material.dart';
import 'package:poke_app/core/sytles/app_colors.dart';
import 'package:poke_app/core/sytles/app_fonts.dart';
import 'package:poke_app/core/utils/app_localizations.dart';
import 'package:poke_app/shared/widget/home_screen_navbar.dart';
import 'package:poke_app/shared/widget/top_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isModalOpen = false;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
  
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeScreenNavbar(),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context).translate("title") ?? "",
                style: AppFonts.titleStyle,
              ),
              const SizedBox(height: 10),
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: AppColors.subTitle,
                ),
                child: Row(
                  children: [
                  const  IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: AppColors.subTitleColor,
                      ),
                      onPressed: null,
                    ),
                    Expanded(
                      child: TextField(
                       
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: AppColors.bodyBackgroundColor,
                        ),
                        cursorHeight: 24,
                       
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)
                                  .translate("title_buscar") ??
                              "",
                          hintStyle: AppFonts.subtitleGrayStyle,
                          contentPadding: const EdgeInsets.only(bottom: 5),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: TopList(
               
                  isModalOpen: _isModalOpen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
