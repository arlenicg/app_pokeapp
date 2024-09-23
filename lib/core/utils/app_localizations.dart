import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  static Map<String, dynamic>? _localizedStrings;

  AppLocalizations(this.locale);

  static Future<void> load(Locale locale) async {
    final String jsonString =
        await rootBundle.loadString(_localizedPath(locale));
    final Map<String, dynamic> decodedJson = json.decode(jsonString);
    _localizedStrings = decodedJson;
  }

  static String _localizedPath(Locale locale) {
    return 'assets/locale/localization_${locale.languageCode}.json';
  }

  String? translate(String key) {
    List<String> keys = key.split('.');
    dynamic value = _localizedStrings;

    for (String subKey in keys) {
      if (value is Map<String, dynamic> && value.containsKey(subKey)) {
        value = value[subKey];
      } else {
        return null;
      }
    }

    return value as String?;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}
