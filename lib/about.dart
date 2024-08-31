import 'package:flutter/material.dart';
import 'package:localization_demo/i18n.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(t('about:title'))),
      body: Center(
        child: Column(
          children: [
            Text(t('about:description')),
            ElevatedButton(
              onPressed: () {
                // final locale = Localizations.localeOf(context).languageCode;
                // final routeManager = await RouteManager.loadRoutesConfig();
                // final route = routeManager.getRoute('home', locale);
                // context.go(route);
              },
              child: Text(t('about:goBackHome')),
            ),
          ],
        ),
      ),
    );
  }
}
