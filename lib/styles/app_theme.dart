import 'package:flutter/material.dart';

class AppTheme {
  ThemeData theme(BuildContext context) {
    return ThemeData(
      textTheme: textTheme(),
      primarySwatch: Colors.deepOrange,
      accentColor: Colors.deepOrangeAccent,
      canvasColor: Colors.white,
      fontFamily: 'Montserrat',
      elevatedButtonTheme: elevatedButtonTheme(context),
      outlinedButtonTheme: outlinedButtonTheme(context),
    );
  }

  TextTheme textTheme() {
    return TextTheme(
      headline1: TextStyle(),
      headline2: TextStyle(),
      headline3: TextStyle(),
      headline4: TextStyle(),
      headline5: TextStyle(),
      headline6: TextStyle(),
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      caption: TextStyle(),
      subtitle1: TextStyle(),
      subtitle2: TextStyle(),
      button: TextStyle(),
      overline: TextStyle(),
    ).apply(
      bodyColor: Colors.grey[900],
      displayColor: Colors.grey[900],
    );
  }

  ElevatedButtonThemeData elevatedButtonTheme(BuildContext context) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle:
            MaterialStateProperty.all(Theme.of(context).textTheme.subtitle1),
        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(25, 10, 25, 10)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  OutlinedButtonThemeData outlinedButtonTheme(BuildContext context) {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle:
            MaterialStateProperty.all(Theme.of(context).textTheme.subtitle1),
        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(25, 10, 25, 10)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
