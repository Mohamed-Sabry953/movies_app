import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/MainCategory/CategoryHome.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Cubit/MovieCubit.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';

import '../../themes/ThemeData.dart';
import 'Taps/BrowserTap/browserTap.dart';
import 'Taps/Home/HomeTap.dart';
import 'Taps/SearchTap.dart';
import 'Taps/watchList/WitchList.dart';

class MovieHomelayout extends StatefulWidget {
  static const String routeName = 'home';
  @override
  State<MovieHomelayout> createState() => _MovieHomelayoutState();
}

  List<Widget> Taps = [HomeTap(), SearchTap(), BrowserTap(), WatchList()];
class _MovieHomelayoutState extends State<MovieHomelayout> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    var provider = Provider.of<MyProvider>(context);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          width: 240,
          child: Column(
            children: [
              Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assests/images/bg.jpg'),
                          fit: BoxFit.fill))),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, CategoryHome.routeName, (route) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.home,size: 28,),
                      SizedBox(width: 3,),
                      Text('Category',style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
            decoration: BoxDecoration(
                image: provider.mode==ThemeMode.light?DecorationImage(
                    image: AssetImage('assests/images/bg.jpg'),
                    fit: BoxFit.fill):DecorationImage(
                    image: AssetImage('assests/images/blackbg.jpg'),
                    fit: BoxFit.fill)),
            child: Taps[currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xff1A1A1A),
          selectedItemColor: Color(0xffFFBB3B),
          unselectedItemColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            provider.parm = '';
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                label: 'Home',
                icon: ImageIcon(AssetImage('assests/images/Homeicon.png')),
                backgroundColor: MyThemeData.light),
            BottomNavigationBarItem(
                label: 'search',
                icon: Icon(Icons.search),
                backgroundColor: MyThemeData.light),
            BottomNavigationBarItem(
                label: 'BROWSE',
                icon: ImageIcon(AssetImage('assests/images/movieIcon.png')),
                backgroundColor: MyThemeData.light),
            BottomNavigationBarItem(
                label: 'WITCHLIST',
                icon: ImageIcon(AssetImage('assests/images/movieList.png')),
                backgroundColor: MyThemeData.light),
          ],
        ),
      ),
    );
  }
}
