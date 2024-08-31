import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18next/i18next.dart';
import 'package:localization_demo/home.dart';
import 'package:localization_demo/i18n.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleModel>(
      create: (_) => LocaleModel(),
      child: Consumer<LocaleModel>(builder: (context, localeModel, child) {
        return MaterialApp(
          title: 'Internationalization Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          localizationsDelegates: [
            ...GlobalMaterialLocalizations.delegates,
            I18NextLocalizationDelegate(
              locales: localeModel.locales,
              dataSource: AssetBundleLocalizationDataSource(
                // This is the path for the files declared in pubspec which should
                // contain all of your localizations
                bundlePath: 'i18n',
              ),
              // extra formatting options can be added here
              options: I18NextOptions(formats: formatters(localeModel.locale)),
            ),
          ],
          home: const MyHomePage(),
          locale: localeModel.locale,
          supportedLocales: localeModel.locales,
        );
      }),
    );
  }

  static Map<String, ValueFormatter> formatters(Locale locale) {
    return {
      'uppercase': (value, format, locale, options) =>
          value?.toString().toUpperCase(),
      'lowercase': (value, format, locale, options) =>
          value?.toString().toLowerCase(),
    };
  }
}
