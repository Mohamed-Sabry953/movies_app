import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  String? parm="";
  String language="en";
  ThemeMode mode=ThemeMode.light;
  Search(String q){
    parm=q;
    notifyListeners();
  }
  ChangeLanguage(String lang){
    language=lang;
    notifyListeners();
  }
  changetheme(ThemeMode Theme) {
    mode = Theme;
    notifyListeners();
  }

}