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

// class LocaleModel with ChangeNotifier {
//   static const List<Locale> locales = [
//     Locale('en', 'US'),
//     Locale('fr', 'FR'),
//   ];
//   late Locale _locale = _getInitialLocale();

//   static Locale _getInitialLocale() {
//     Locale systemLocale = PlatformDispatcher.instance.locale;

//     if (locales.contains(systemLocale)) {
//       return systemLocale;
//     } else {
//       return const Locale('en', 'US');
//     }
//   }

//   Locale get locale => _locale;

//   void setLocale(Locale locale) {
//     _locale = locale;
//     ApiService.setHeaders({
//       'x-custom-lang': locale.languageCode,
//     });
//     notifyListeners();
//   }
// }
