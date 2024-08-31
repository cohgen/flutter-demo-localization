import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18next/i18next.dart';
import 'package:intl/intl.dart';
import 'package:localization_demo/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  final List<Locale> locales = const [
    Locale('en', 'US'),
    Locale('fr', 'FR'),
  ];

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale locale;

  @override
  void initState() {
    super.initState();
    locale = widget.locales.first;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internationalization Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        I18NextLocalizationDelegate(
          locales: widget.locales,
          dataSource: AssetBundleLocalizationDataSource(
            // This is the path for the files declared in pubspec which should
            // contain all of your localizations
            bundlePath: 'i18n',
          ),
          // extra formatting options can be added here
          options: I18NextOptions(formats: formatters()),
        ),
      ],
      home: MyHomePage(
        supportedLocales: widget.locales,
        onUpdateLocale: updateLocale,
      ),
      locale: locale,
      supportedLocales: widget.locales,
    );
  }

  void updateLocale(Locale newLocale) {
    setState(() {
      locale = newLocale;
    });
  }

  static Map<String, ValueFormatter> formatters() => {
        'uppercase': (value, format, locale, options) =>
            value?.toString().toUpperCase(),
        'lowercase': (value, format, locale, options) =>
            value?.toString().toLowerCase(),
        'datetime': (value, format, locale, options) {
          if (value is! DateTime) return value;
          var dateFormat = format.options['format'];
          dateFormat = dateFormat is String ? dateFormat : 'dd/MM/yyyy';
          return DateFormat(dateFormat, locale.toString()).format(value);
        },
      };
}
