<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# jlt_app_theme_handler

A custom solution for handling themes across the JLT software suite. This package provides a centralized way to manage app-wide theme data, colors, padding, border radius, and logo assets in your Flutter applications.

## Features

- Singleton `AppTheme` class for global theme management
- Reactive theme updates using `ValueNotifier<ThemeData>`
- Customizable primary color, background color, padding, and border radius
- Asset management for logos and fonts
- Uses [tinycolor2](https://pub.dev/packages/tinycolor2) for color manipulation
- Includes Poppins font family with multiple weights and styles

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  jlt_app_theme_handler: ^0.0.4
```

Run `flutter pub get` to install dependencies.

## Usage

Import the package and use the `AppTheme` singleton:

```dart
import 'package:jlt_app_theme_handler/jlt_app_theme_handler.dart';

final appTheme = AppTheme();

// Listen to theme changes
ValueListenableBuilder<ThemeData>(
  valueListenable: appTheme.theme,
  builder: (context, theme, child) {
    return MaterialApp(
      theme: theme,
      home: MyHomePage(),
    );
  },
);

// Update theme
appTheme.updateTheme(ThemeData.dark());

// Access and modify theme properties
Color primary = appTheme.getPrimaryColour();
appTheme.setPrimaryColour(primaryColour: Colors.blue);
EdgeInsets padding = appTheme.getAppPadding();
appTheme.setAppPadding(edgeInsets: EdgeInsets.all(16));
```

## Assets & Fonts

This package includes logo assets and the Poppins font family. Make sure to declare them in your `pubspec.yaml`:

```yaml
flutter:
  assets:
    - lib/assets/
  fonts:
    - family: Poppins
      fonts:
        - asset: lib/assets/fonts/Poppins-Thin.ttf
          weight: 100
        # ...other font assets
```

## Contributing

Contributions are welcome! Please open issues or submit pull requests on the [GitHub repository](https://github.com/your-repo-url).

## License

This project is licensed under the terms of the LICENSE file.
