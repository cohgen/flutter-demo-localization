# localization_demo

A Flutter demo project to show how to integrate localization in your app.

This demo uses the following packages:

- i18next for internationalization
- go_router for routing

##  1. Why these Flutter packages:

### 1.1 i18next instead of flutter_localizations

https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization
https://pub.dev/packages/i18next
https://www.i18next.com

### 1.2 go_router instead of Navigator

https://docs.flutter.dev/ui/navigation
https://pub.dev/packages/go_router

## 2.Create project

```
flutter create localization_demo
```

Clean all comments

## 3. Internationalization

### 3.1 Setup

- Install i18next

Run these flutter commands in the root of the project:

````
flutter pub add flutter_localizations --sdk=flutter
flutter pub add intl:any
flutter pub add i18next
````

This will add a line like this to your package's pubspec.yaml (and run an implicit `flutter pub get`):

```
dependencies:
  # ...
  flutter_localizations:
    sdk: flutter
  intl: any
  i18next: ^0.7.3
```

- Create in the root of the project the following folders

  - i18n/en-US
  - i18n/fr-FR
  - ... whatever language

- Add the assets

In `pubspec.yaml`, add the following section:

```
# The following section is specific to Flutter packages.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # Add the following assets (1 folder per language)
  assets:
  - i18n/en-US/
  - i18n/fr-FR/
  # - other languages
```

### 3.2 Start coding (version 0.1.0)

- move Home widget in a separate file called `home.dart`

- in `main.dart`
  - convert MyApp to StatefulWidget
  - add supported locales
  - add localization initialization code snippet in MaterialApp constructor

- add translation files in `i18n/<language>`

- create `i18n.dart` and copy paste following code snippet:

```
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
```

- change `home.dart` 

## 4. Locale detection at startup and global availability of locales (version 0.2.0)

### 4.1 Install `provider`

Run this flutter command in the root of the project:

````
flutter pub add provider
````

### 4.2 Change code

- In `i18n.dart`, define the LocaleModel class that will handle all locale related stuff

- In `main.dart`, alter the code to provide LocaleModel and consume it.

- In `home.dart`, simplify the code

- Fix error with datetime formatter, which does not work well with json, due to HTML-encoding of '/' character to '&#x2F;'
  Tip: in general, prefer doing the string formatting before calling translation

