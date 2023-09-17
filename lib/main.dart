import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/MainCategory/CategoryHome.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Homelayout.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/BrowserTap/MovieByCategory.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/Movepage.dart';
import 'package:movies_app/Login/LoginPage.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Homelayout.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Taps/BrowserTap/MovieByCategory.dart';
import 'package:movies_app/Signup/SignUp.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(create:
      (context) => MyProvider(),child: const MyApp()),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        MovieHomelayout.routeName:(context)=>MovieHomelayout(),
        Movepage.routeName:(context)=>Movepage(),
        MovieCategory.routeName:(context)=>MovieCategory(),
        LoginPage.routeName:(context)=>LoginPage(),
        SeriesHomelayout.routeName:(context)=>SeriesHomelayout(),
        SeriesCategory.routeName:(context)=>SeriesCategory(),
        CategoryHome.routeName:(context)=>CategoryHome(),
        SignUpPage.routeName:(context)=>SignUpPage(),
        LoginPage.routeName:(context)=>LoginPage(),
      },
      initialRoute:LoginPage.routeName ,
      themeMode: ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      title: 'Localizations Sample App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
    );  }
}

