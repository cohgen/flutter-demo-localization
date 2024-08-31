import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization_demo/i18n.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.supportedLocales,
    required this.onUpdateLocale,
  });

  final List<Locale> supportedLocales;
  final ValueChanged<Locale> onUpdateLocale;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _gender = '';

  void incrementCounter() => setState(() => _counter++);
  void resetCounter() => setState(() => _counter = 0);
  void updateGender(String gender) => setState(() => _gender = gender);

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(t('home:title')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        tooltip: t('counter:clickMe'),
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CupertinoSegmentedControl<Locale>(
                children: {
                  for (final e in widget.supportedLocales) e: Text(e.toString())
                },
                groupValue: Localizations.localeOf(context),
                onValueChanged: widget.onUpdateLocale,
              ),
              const Divider(),
              Text(
                t('home:helloMessage',
                    variables: {'name': 'Name', 'world': 'Flutter'}),
              ),
              Text(
                t('home:today', variables: {'date': DateTime.now()}),
              ),
              CupertinoSegmentedControl<String>(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: const {
                  'male': Text('MALE'),
                  'female': Text('FEMALE'),
                  '': Text('OTHER'),
                },
                groupValue: _gender,
                onValueChanged: updateGender,
              ),
              Text(t('home:gender.message', context: _gender)),
              const Divider(),
              Text(
                t('counter:clicked', count: _counter),
              ),
              TextButton(
                onPressed: resetCounter,
                child: Text(t('counter:resetCounter')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
