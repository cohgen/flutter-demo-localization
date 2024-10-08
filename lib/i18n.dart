import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:i18next/i18next.dart';

extension I18n on BuildContext {
  String Function(
    String, {
    String? context,
    int? count,
    Locale? locale,
    I18NextOptions? options,
    String Function(String)? orElse,
    Map<String, dynamic>? variables,
  }) get t => I18Next.of(this)!.t;
}

class LocaleModel with ChangeNotifier {
  static const List<Locale> _locales = [
    Locale('en', 'US'),
    Locale('fr', 'FR'),
  ];
  late Locale _locale = _getInitialLocale();

  static Locale _getInitialLocale() {
    Locale systemLocale = PlatformDispatcher.instance.locale;

    if (_locales.contains(systemLocale)) {
      return systemLocale;
    } else {
      return _locales.first;
    }
  }

  Locale get locale => _locale;
  List<Locale> get locales => _locales;

  void setLocale(Locale locale) {
    print('setLocale: ${locale.toString()}');
    if (_locales.contains(locale)) {
      _locale = locale;
    } else {
      print('locale does not exist, fallback to en-US');
      _locale = _locales.first;
    }
    notifyListeners();
  }
}
