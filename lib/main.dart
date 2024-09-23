import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/shared/routing/router_app.dart';

import 'core/utils/app_localizations_delegate.dart';



Future<void> main() async {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return MaterialApp.router(
      debugShowCheckedModeBanner: false,
     routerConfig: RouterApp.router,
      title: 'Poke App',
     
       locale: const Locale('es'), 
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const[

         Locale('es', ''),
      ],
    );
  }
}

