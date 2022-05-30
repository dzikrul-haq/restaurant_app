import 'package:flutter/cupertino.dart';

class PreferenceProvider extends ChangeNotifier {
  // pada saat ini hanya menyimpan data bahasa
  Locale _locale = const Locale("id");

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
