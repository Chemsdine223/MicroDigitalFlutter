import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(
    this.locale,
  );

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> localizedStrings;

  Future load() async {
    String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    if (locale.languageCode != window.locale.languageCode) {
      jsonString = await rootBundle
          .loadString('lang/${window.locale.languageCode}.json');
      jsonMap = json.decode(jsonString);

      jsonMap.forEach((key, value) {
        localizedStrings[key] = value.toString();
      });
    }
  }

  String translate(String key) {
    return localizedStrings[key] ?? '';
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {

    return ['en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {

    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
