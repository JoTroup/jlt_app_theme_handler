import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:jlt_app_theme_handler/jlt_app_theme_handler.dart';

void main() {
  final testBinding = TestWidgetsFlutterBinding.ensureInitialized();
  late AppTheme appTheme;

  setUp(() {
    appTheme = AppTheme();
    appTheme.setDefaultFontFamily(fontFamily: 'Poppins');
    appTheme.clearDefaultGoogleFontFamily();
    for (final textType in AppTextType.values) {
      appTheme.clearTextTypeFontFamily(textType: textType);
      appTheme.clearTextTypeGoogleFontFamily(textType: textType);
    }
  });

  tearDown(() {
    testBinding.platformDispatcher.views.first.resetPhysicalSize();
    testBinding.platformDispatcher.views.first.resetDevicePixelRatio();
  });

  testWidgets('isDevicePortrait returns true for portrait size',
      (tester) async {
    tester.view.devicePixelRatio = 2.0;
    tester.view.physicalSize = const Size(1080, 1920);

    expect(appTheme.isDevicePortrait(), isTrue);
  });

  testWidgets('isDevicePortrait returns false for landscape size',
      (tester) async {
    tester.view.devicePixelRatio = 2.0;
    tester.view.physicalSize = const Size(1920, 1080);

    expect(appTheme.isDevicePortrait(), isFalse);
  });

  testWidgets('isDevicePortrait returns true for square size', (tester) async {
    tester.view.devicePixelRatio = 2.0;
    tester.view.physicalSize = const Size(1000, 1000);

    expect(appTheme.isDevicePortrait(), isTrue);
  });

  testWidgets('setDefaultFontFamily updates theme defaults', (tester) async {
    appTheme.setDefaultFontFamily(fontFamily: 'Roboto');

    final themeData = appTheme.getThemeData();
    expect(appTheme.getDefaultFontFamily(), 'Roboto');
    expect(themeData.textTheme.displayLarge?.fontFamily, 'Roboto');
    expect(themeData.textTheme.bodyLarge?.fontFamily, 'Roboto');
  });

  testWidgets('setTextTypeFontFamily overrides a specific text type',
      (tester) async {
    appTheme.setDefaultFontFamily(fontFamily: 'Poppins');
    appTheme.setTextTypeFontFamily(
      textType: AppTextType.h1,
      fontFamily: 'Montserrat',
    );

    final themeData = appTheme.getThemeData();
    expect(themeData.textTheme.displayLarge?.fontFamily, 'Montserrat');
    expect(themeData.textTheme.displayMedium?.fontFamily, 'Poppins');
    expect(themeData.textTheme.bodyLarge?.fontFamily, 'Poppins');
  });

  testWidgets('font setters reject empty families', (tester) async {
    expect(
      () => appTheme.setDefaultFontFamily(fontFamily: '   '),
      throwsA(isA<ArgumentError>()),
    );
    expect(
      () => appTheme.setTextTypeFontFamily(
        textType: AppTextType.h1,
        fontFamily: '',
      ),
      throwsA(isA<ArgumentError>()),
    );
  });

  testWidgets('setDefaultGoogleFontFamily applies Google Font globally',
      (tester) async {
    appTheme.setDefaultGoogleFontFamily(googleFontFamily: 'Lato');

    final themeData = appTheme.getThemeData();
    expect(appTheme.getDefaultGoogleFontFamily(), 'Lato');
    expect(themeData.textTheme.displayLarge?.fontFamily, startsWith('Lato'));
    expect(themeData.textTheme.bodyLarge?.fontFamily, startsWith('Lato'));
  });

  testWidgets('setTextTypeGoogleFontFamily overrides one text type',
      (tester) async {
    appTheme.setDefaultGoogleFontFamily(googleFontFamily: 'Lato');
    appTheme.setTextTypeGoogleFontFamily(
      textType: AppTextType.h1,
      googleFontFamily: 'Montserrat',
    );

    final themeData = appTheme.getThemeData();
    expect(
      themeData.textTheme.displayLarge?.fontFamily,
      startsWith('Montserrat'),
    );
    expect(themeData.textTheme.displayMedium?.fontFamily, startsWith('Lato'));
  });

  testWidgets('clearDefaultGoogleFontFamily reverts to local families',
      (tester) async {
    appTheme.setDefaultFontFamily(fontFamily: 'Poppins');
    appTheme.setDefaultGoogleFontFamily(googleFontFamily: 'Lato');
    appTheme.clearDefaultGoogleFontFamily();

    final themeData = appTheme.getThemeData();
    expect(themeData.textTheme.displayLarge?.fontFamily, 'Poppins');
    expect(themeData.textTheme.bodyLarge?.fontFamily, 'Poppins');
  });
}
