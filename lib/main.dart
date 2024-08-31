import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:i18next/i18next.dart';
// import 'package:localization_demo/about.dart';
import 'package:localization_demo/home.dart';
import 'package:localization_demo/i18n.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) usePathUrlStrategy();
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
        return MaterialApp.router(
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
          locale: localeModel.locale,
          supportedLocales: localeModel.locales,
          routerConfig: createRouter(localeModel.locale, context),
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

  GoRouter createRouter(Locale locale, BuildContext context) {
    return GoRouter(
      debugLogDiagnostics: false,
      routes: [
        GoRoute(
          path: '/',
          redirect: (BuildContext context, GoRouterState state) {
            return '/${locale.toString()}';
          },
        ),
        GoRoute(
          path: '/:locale',
          builder: (context, state) {
            if (state.pathParameters['locale'] == null ||
                state.pathParameters['locale']!.isEmpty) {
              print('zdazd');
              return const MyHomePage();
            } else {
              print('hzz');
              return MyHomePage(localeParam: state.pathParameters['locale']);
            }
          },
        ),
        // GoRoute(
        //   path: '/:locale/${t('routes:home')}',
        //   builder: (context, state) => const MyHomePage(),
        // ),
        // GoRoute(
        //   path: '/:locale/${t('routes:about')}',
        //   builder: (context, state) => const AboutPage(),
        // ),
      ],
    );
  }
}
