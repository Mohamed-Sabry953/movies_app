import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';

import 'Homelayout/Homelayout.dart';
import 'Homelayout/Taps/BrowserTap/MovieByCategory.dart';
import 'Homelayout/Taps/Home/Movepage.dart';
import 'Homelayout/Taps/LoginPage.dart';
import 'firebase_options.dart';

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
        Homelayout.routeName:(context)=>Homelayout(),
        Movepage.routeName:(context)=>Movepage(),
        MovieCategory.routeName:(context)=>MovieCategory(),
        LoginPage.routeName:(context)=>LoginPage(),
      },
      initialRoute:Homelayout.routeName ,
      themeMode: ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

    );  }
}

