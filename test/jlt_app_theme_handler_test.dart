import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:jlt_app_theme_handler/jlt_app_theme_handler.dart';

void main() {
  final appTheme = AppTheme();

  tearDown(() {
    final testBinding = TestWidgetsFlutterBinding.ensureInitialized();
    testBinding.platformDispatcher.views.first.resetPhysicalSize();
    testBinding.platformDispatcher.views.first.resetDevicePixelRatio();
  });

  testWidgets('isDevicePortrait returns true for portrait size', (tester) async {
    tester.view.devicePixelRatio = 2.0;
    tester.view.physicalSize = const Size(1080, 1920);

    expect(appTheme.isDevicePortrait(), isTrue);
  });

  testWidgets('isDevicePortrait returns false for landscape size', (tester) async {
    tester.view.devicePixelRatio = 2.0;
    tester.view.physicalSize = const Size(1920, 1080);

    expect(appTheme.isDevicePortrait(), isFalse);
  });

  testWidgets('isDevicePortrait returns true for square size', (tester) async {
    tester.view.devicePixelRatio = 2.0;
    tester.view.physicalSize = const Size(1000, 1000);

    expect(appTheme.isDevicePortrait(), isTrue);
  });
}
