import 'package:flutter/material.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';

import '../../themes/ThemeData.dart';
import 'Taps/BrowserTap/browserTap.dart';
import 'Taps/Home/HomeTap.dart';
import 'Taps/SearchTap.dart';
import 'Taps/watchList/WitchList.dart';

class Homelayout extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<Homelayout> createState() => _HomelayoutState();
}

class _HomelayoutState extends State<Homelayout> {
  int currentIndex=0;
  List<Widget>Taps=[HomeTap(),SearchTap(),BrowserTap(),WatchList()];

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return SafeArea(
      child: Scaffold(

        drawer: Drawer(
          width: 240,
        ),
        backgroundColor: Colors.black,
        body: Taps[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xff1A1A1A),
          selectedItemColor: Color(0xffFFBB3B),
          unselectedItemColor: Colors.white,
          currentIndex:currentIndex ,
          onTap: (value) {
            currentIndex=value;
            provider.parm='';
            setState(() {

            });
          },
          items: [
            BottomNavigationBarItem(label: 'Home', icon: ImageIcon(AssetImage('assests/images/Homeicon.png')),backgroundColor: MyThemeData.light),
            BottomNavigationBarItem(label: 'search', icon:Icon(Icons.search) ,backgroundColor: MyThemeData.light),
            BottomNavigationBarItem(label: 'BROWSE', icon:ImageIcon(AssetImage('assests/images/movieIcon.png')) ,backgroundColor: MyThemeData.light),
            BottomNavigationBarItem(label: 'WITCHLIST', icon: ImageIcon(AssetImage('assests/images/movieList.png')),backgroundColor: MyThemeData.light),
          ],
        ),
      ),
    );
  }
}
