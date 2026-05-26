import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {

  static const String _primaryColourKey = 'jlt_app_theme_handler.primary_colour';
  static const String _primaryGreyKey = 'jlt_app_theme_handler.primary_grey';

  static final AppTheme _singleton = AppTheme._internal();

  factory AppTheme() {
    return _singleton;
  }

  AppTheme._internal() {
    theme = ValueNotifier<ThemeData>(getThemeData());
    unawaited(loadFromPreferences());
  }

  late ValueNotifier<ThemeData> theme;

  String appLogoAssetString = "assets/ob-logo.png";
  Color _primaryColour = TinyColor.fromString("#FF5400").toColor();
  Color _primaryGrey =  Colors.grey.shade200;
  EdgeInsets _setPadding = EdgeInsets.all(24.0);
  BorderRadius _setBorderRadius = BorderRadius.circular(16);
  int currentViewIndex = 0;

  BorderRadius primaryBorderRadius = BorderRadius.circular(35);



  void updateTheme(ThemeData newTheme) {
    theme.value = newTheme;
  }

  bool isDeviceSmall() {
    final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
    final logicalShortestSide =
        firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
    if (logicalShortestSide < 600) {
      return true;
    }

    return false;
  }

  bool isDevicePortrait() {
    final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
    final logicalWidth =
        firstView.physicalSize.width / firstView.devicePixelRatio;
    final logicalHeight =
        firstView.physicalSize.height / firstView.devicePixelRatio;

    return logicalHeight >= logicalWidth;
  }

  bool isDeviceSmallPortrait() {
    return isDeviceSmall() && isDevicePortrait();
  }

  Color getPrimaryColour() {
    return _primaryColour;
  }

  void setPrimaryColour({required primaryColour}) {
    _primaryColour = primaryColour;
    _scheduleThemePersist();
  }

  Color getPrimaryAccentColour() {
    return TinyColor.fromColor(_primaryColour).spin(10).toColor();
  }

  getPrimaryBackgroundColour() {
    return _primaryGrey;
  }

  setPrimaryBackgroundColour({required primaryBackgroundColour}) {
    _primaryGrey = primaryBackgroundColour;
    _scheduleThemePersist();
  }

  EdgeInsets getAppPadding() {
    final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
    final logicalShortestSide =
        firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
    if (logicalShortestSide < 600) {
      _setPadding = EdgeInsets.all(16);
    }

    return _setPadding;
  }

  setAppPadding({required edgeInsets}) {
    _setPadding = edgeInsets;
  }

  BorderRadius getAppRadius() {
    return _setBorderRadius;
  }

  setAppRadius({required borderRadius}) {
    _setBorderRadius = borderRadius;
  }


  /// Font Face and general theme data settings are set here. This is called when the app theme is updated, and the returned ThemeData is passed to the theme notifier.

  getH1TextStyle({Color? color, FontWeight? fontWeight, bool subHeading = false}) {
    return TextStyle(
        fontSize: isDevicePortrait() ? 28 : 32,
        fontWeight: subHeading ? FontWeight.w700 : (fontWeight ?? FontWeight.w900),
        color: TinyColor.fromColor((color ?? Colors.black54)).lighten(subHeading ? 20 : 0).toColor()
    );
  }

  getH2TextStyle({Color? color, FontWeight? fontWeight, bool subHeading = false}) {
    return TextStyle(
        fontSize: isDevicePortrait() ? 16 : 16,
        fontWeight: subHeading ? FontWeight.w600 : (fontWeight ?? FontWeight.w800),
        color: TinyColor.fromColor((color ?? Colors.black54)).lighten(subHeading ? 20 : 0).toColor()
    );
  }

  getH3TextStyle({Color? color, FontWeight? fontWeight, bool subHeading = false}) {
    return TextStyle(
        fontSize: isDevicePortrait() ? 14 : 14,
        fontWeight: subHeading ? FontWeight.w500 : (fontWeight ?? FontWeight.w700),
        color: TinyColor.fromColor((color ?? Colors.black54)).lighten(subHeading ? 20 : 0).toColor()
    );
  }

  getBodyTextStyle({Color? color, FontWeight? fontWeight, bool subHeading = false}) {
    return TextStyle(
        fontSize:  isDevicePortrait() ? 12 : 12,
        fontWeight: subHeading ? FontWeight.w400 : (fontWeight ?? FontWeight.w500),
        color: TinyColor.fromColor((color ?? Colors.black54)).lighten(subHeading ? 20 : 0).toColor()
    );
  }


  ThemeData getThemeData({Color? colour}) {

    _primaryColour = colour ?? _primaryColour;

    Map<int, Color> color = {
      50:Color.fromRGBO(_primaryColour.r.toInt(),_primaryColour.g.toInt(),_primaryColour.b.toInt(), .1),
      100:Color.fromRGBO(_primaryColour.r.toInt(),_primaryColour.g.toInt(),_primaryColour.b.toInt(),.2),
      200:Color.fromRGBO(_primaryColour.r.toInt(),_primaryColour.g.toInt(),_primaryColour.b.toInt(), .3),
      300:Color.fromRGBO(_primaryColour.r.toInt(),_primaryColour.g.toInt(),_primaryColour.b.toInt(), .4),
      400:Color.fromRGBO(_primaryColour.r.toInt(),_primaryColour.g.toInt(),_primaryColour.b.toInt(), .5),
      500:Color.fromRGBO(_primaryColour.r.toInt(),_primaryColour.g.toInt(),_primaryColour.b.toInt(), .6),
      600:Color.fromRGBO(_primaryColour.r.toInt(),_primaryColour.g.toInt(),_primaryColour.b.toInt(), .7),
      700:Color.fromRGBO(_primaryColour.r.toInt(),_primaryColour.g.toInt(),_primaryColour.b.toInt(), .8),
      800:Color.fromRGBO(_primaryColour.r.toInt(),_primaryColour.g.toInt(),_primaryColour.b.toInt(), .9),
      900:Color.fromRGBO(_primaryColour.r.toInt(),_primaryColour.g.toInt(),_primaryColour.b.toInt(), 1),
    };

    return ThemeData(
      fontFamily: "Poppins",
      useMaterial3: true,
      splashColor: getPrimaryAccentColour().withValues(alpha: 0.2),
      highlightColor: _primaryColour.withValues(alpha: 0.3),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.black87,
          size: 18
        ),

        titleTextStyle: getH2TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)
      ),


      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.only(left: 16, right: 16)),
          visualDensity: VisualDensity.compact,
          splashFactory: InkRipple.splashFactory,
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          foregroundColor: WidgetStatePropertyAll(_primaryColour)
        )
      ),


      progressIndicatorTheme: ProgressIndicatorThemeData(
        strokeCap: StrokeCap.round,
        circularTrackColor: Colors.grey.shade200,
        strokeWidth: 6,
        trackGap: 6,
      ),

      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(_primaryColour.withValues(alpha: 0.5)),
        trackColor: WidgetStatePropertyAll(_primaryColour.withValues(alpha: 0.9)),
        trackBorderColor: WidgetStatePropertyAll(Colors.transparent),
        radius: const Radius.circular(10),
        thickness: WidgetStatePropertyAll(6),
      ),



      switchTheme: SwitchThemeData(
          splashRadius: 20 ,
          overlayColor: WidgetStatePropertyAll(_primaryColour),

          thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (!states.contains(WidgetState.selected)) {
              return Colors.black26;
            } else {
              return Colors.white;
            }
          }),
          trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states) {

            if (!states.contains(WidgetState.selected)) {
              return Colors.black26;
            } else {
              return _primaryColour;
            }
          })
      ),

      radioTheme: RadioThemeData(
          fillColor: WidgetStatePropertyAll(_primaryColour)
      ),

      colorScheme: ColorScheme.fromSwatch(
        backgroundColor:  Colors.white,
        primarySwatch: MaterialColor(_primaryColour.toARGB32(), color),
      ),

      iconTheme: const IconThemeData(
          color: Colors.black54
      ),

      inputDecorationTheme: InputDecorationTheme(
          contentPadding: getAppPadding().copyWith(top: 0, bottom: 0)/2,
          fillColor: _primaryGrey,
          filled: true,
          iconColor: _primaryColour,
          helperStyle: getBodyTextStyle(),

          // Unfocused outline
          enabledBorder: OutlineInputBorder(
            borderRadius: _setBorderRadius,
            borderSide: BorderSide(
              color: Colors.transparent, // <- unfocused stroke color
              width: 1.2,            // <- unfocused stroke width
            ),
          ),

          // Focused outline
          focusedBorder: OutlineInputBorder(
            borderRadius: _setBorderRadius,
            borderSide: BorderSide(
              color: _primaryColour,
              width: 1.8,
            ),
          ),


          /*border: UnderlineInputBorder(
            borderRadius: _setBorderRadius,
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),*/
          prefixStyle: getBodyTextStyle(color: _primaryColour),
          floatingLabelBehavior: FloatingLabelBehavior.always, // <----- just add this
          hintStyle: getBodyTextStyle(color: Colors.black26)
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: getBodyTextStyle(),
          menuStyle: MenuStyle(
              alignment: Alignment.center,
              side: WidgetStatePropertyAll(
                  BorderSide(color: _primaryColour.withValues(alpha: 0.3)),
              ),
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: _setBorderRadius)
              ),
            backgroundColor: WidgetStatePropertyAll(Colors.white.withValues(alpha: 0.95)),
            elevation: WidgetStatePropertyAll(4),
            visualDensity: VisualDensity.compact,
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: getAppPadding().copyWith(top: 0, bottom: 0)/2,
            fillColor: _primaryGrey,
            filled: true,
            iconColor: _primaryColour,
            helperStyle: getBodyTextStyle(),
            visualDensity: VisualDensity.compact,
            labelStyle: getBodyTextStyle(color: _primaryColour),
            floatingLabelStyle: getBodyTextStyle(color: _primaryColour),
            floatingLabelBehavior: FloatingLabelBehavior.always, // <----- just add this
            hintStyle: getBodyTextStyle(color: Colors.black26),
            enabledBorder: OutlineInputBorder(
                  borderRadius: _setBorderRadius,
                  borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.2,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: _setBorderRadius,
                  borderSide: BorderSide(
                      color: _primaryColour,
                      width: 1.8,
                  )
              ),
              border: OutlineInputBorder(
                  borderRadius: _setBorderRadius,
                  borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.2,
                  )
              ),
          )
      ),

      dialogTheme: DialogThemeData(

      )

    );
  }

  Future<void> loadFromPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedPrimary = prefs.getInt(_primaryColourKey);
      final storedGrey = prefs.getInt(_primaryGreyKey);

      if (storedPrimary != null) {
        _primaryColour = Color(storedPrimary);
      }
      if (storedGrey != null) {
        _primaryGrey = Color(storedGrey);
      }

      theme.value = getThemeData();
    } catch (_) {
      // SharedPreferences can be unavailable in tests; ignore.
    }
  }

  void _scheduleThemePersist() {
    unawaited(_persistTheme());
  }

  Future<void> _persistTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_primaryColourKey, _primaryColour.toARGB32());
      await prefs.setInt(_primaryGreyKey, _primaryGrey.toARGB32());
    } catch (_) {
      // SharedPreferences can be unavailable in tests; ignore.
    }
  }
}
