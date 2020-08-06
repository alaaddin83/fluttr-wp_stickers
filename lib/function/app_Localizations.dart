import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizationStrings;

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString("lang/${locale.languageCode}.json");

    print('language is : $jsonString');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    print('language is : $jsonString');

    _localizationStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  // This method will be called from every widget which needs a localized text
  String TranslationValue(String key) {
    return _localizationStrings[key];
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = new AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    // TODO: implement shouldReload
    return false;
  }
}
