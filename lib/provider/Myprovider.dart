import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  String? parm="";
  Search(String q){
    parm=q;
    notifyListeners();
  }
}