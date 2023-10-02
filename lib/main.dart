import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Login/Cubit.dart';
import 'package:movies_app/Login/States.dart';
import 'package:movies_app/MainCategory/CategoryHome.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Homelayout.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/BrowserTap/MovieByCategory.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/Movepage.dart';
import 'package:movies_app/Login/LoginPage.dart';
import 'package:movies_app/MainCategory/PersonalProfile/Profile.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Homelayout.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Taps/BrowserTap/MovieByCategory.dart';
import 'package:movies_app/MainCategory/Settingpage/SettingPage.dart';
import 'package:movies_app/Signup/SignUp.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:movies_app/themes/ThemeData.dart';
import 'package:provider/provider.dart';
import 'Bloc_Observer.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  Bloc.observer=MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
  BlocProvider(create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit,LoginStates>(
    builder: (context, state) {
      return ChangeNotifierProvider(create:
          (context) => MyProvider(),child: const MyApp());
    },
    listener: (context, state) {
      if(state is LoginErrorState){
        Text('error');
      }
      else if(state is LoginSucssesState){

      }
      else if(state is LoginLodingState){
        CircularProgressIndicator();
      }
    },
  ),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
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
        SettingPage.routeName:(context)=>SettingPage(),
        Profile.routeName:(context)=>Profile(),
      },
      initialRoute:
      LoginCubit.get(context).firebaseuser==null?LoginPage.routeName:CategoryHome.routeName,
      themeMode: provider.mode,
      theme: MyThemeData.lightmode,
      darkTheme: MyThemeData.darkmode,
      title: 'Localizations Sample App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(provider.language),
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
    );  }
}

