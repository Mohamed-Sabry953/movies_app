import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  String? parm="";
  String language="en";
  Search(String q){
    parm=q;
    notifyListeners();
  }
  ChangeLanguage(String lang){
    language=lang;
    notifyListeners();
  }
}