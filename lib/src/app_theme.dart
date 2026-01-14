
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor2/tinycolor2.dart';

class AppTheme {

  static final AppTheme _singleton = AppTheme._internal();

  factory AppTheme() {
    return _singleton;
  }

  AppTheme._internal() {
    theme = ValueNotifier<ThemeData>(getThemeData());
  }

  TextStyle primarySubMenuHeadingStyle = TextStyle(fontWeight: FontWeight.w800, fontSize: 16,);

  late ValueNotifier<ThemeData> theme;

  String appLogoAssetString = "assets/ob-logo.png";
  Color _primaryColour = TinyColor.fromString("#FF5400").toColor();
  Color _primaryGrey =  Colors.grey.shade200;
  EdgeInsets _setPadding = EdgeInsets.all(24.0);
  final BorderRadius _setBorderRadius = BorderRadius.circular(16);
  int currentViewIndex = 0;

  BorderRadius primaryBorderRadius = BorderRadius.circular(35);



  void updateTheme(ThemeData newTheme) {
    theme.value = newTheme;
  }

  bool getDeviceSmall() {
    final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
    final logicalShortestSide =
        firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
    if (logicalShortestSide < 600) {
      return true;
    }

    return false;
  }

  getPrimaryColour() {
    return _primaryColour;
  }

  setPrimaryColour({required primaryColour}) {
    _primaryColour = primaryColour;
  }

  getPrimaryBackgroundColour() {
    return _primaryGrey;
  }

  setPrimaryBackgroundColour({required primaryBackgroundColour}) {
    _primaryGrey = primaryBackgroundColour;
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


  ThemeData getThemeData({Color? colour}) {

    _primaryColour = colour ?? _primaryColour;

    Map<int, Color> color =
    {
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
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.black87,
          size: 18
        ),

        titleTextStyle: TextStyle(
            fontFamily: "Poppins",
            fontSize: kIsWeb ? 14 : 14,
            color: Colors.black87,
            fontWeight: FontWeight.w900
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          splashFactory: InkRipple.splashFactory,
          backgroundColor: WidgetStatePropertyAll(_primaryColour),
          foregroundColor: WidgetStatePropertyAll(Colors.white)
        )
      ),



      switchTheme: SwitchThemeData(
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
          filled: true,
          fillColor: Colors.grey.shade300,
          iconColor: _primaryColour,
          helperStyle: const TextStyle(color: Colors.black54),
          prefixStyle: const TextStyle(fontSize: 14),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(25)),
          )
      ),

      dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black54
          ),
          menuStyle: MenuStyle(
              alignment: Alignment.center,
              side: WidgetStatePropertyAll(
                  BorderSide.none
              ),
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)))
              )
          ),
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
              )
          )
      ),

      dialogTheme: DialogThemeData(

      )

    );
  }

}

