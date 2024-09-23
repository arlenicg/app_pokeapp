import 'package:flutter/material.dart';
import 'package:poke_app/core/sytles/app_colors.dart';

class HomeScreenNavbar extends StatelessWidget {
  const HomeScreenNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bodyBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Image.asset('assets/images/iconburguer.png'),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundColor: AppColors.textTitle,
            backgroundImage: AssetImage('assets/images/avatar.png'),
            radius: 18,
          ),
        ],
      ),
    );
  }
}
