import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:vehicles_app/constants/locales.dart';

class LanguageChangeNotifierProvider with ChangeNotifier {
  Locale _currentLocale = EN;
  String _currentLocaleString = EN_STRING;

  Locale get currentLocale => _currentLocale;

  String get currentLocaleString => _currentLocaleString;

  void changeLocale(Locale _locale) {
    this._currentLocale = _locale;
    if (this._currentLocale == PL) {
      this._currentLocaleString = PL_STRING;
    } else {
      this._currentLocaleString = EN_STRING;
    }
    notifyListeners();
  }

  void changeLocaleFromString(String _localeString) {
    if (_localeString == EN_STRING) {
      this._currentLocale = EN;
      this._currentLocaleString = EN_STRING;
    } else if (_localeString == PL_STRING) {
      this._currentLocale = PL;
      this._currentLocaleString = PL_STRING;
    }
    notifyListeners();
  }

  void toggleLocale() {
    if (this._currentLocale == PL) {
      this._currentLocale = EN;
      this._currentLocaleString = EN_STRING;
    } else {
      this._currentLocale = PL;
      this._currentLocaleString = PL_STRING;
    }
    notifyListeners();
  }
}
