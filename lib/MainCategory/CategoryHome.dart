import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Login/Cubit.dart';
import 'package:movies_app/Login/LoginPage.dart';
import 'package:movies_app/Login/States.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Cubit/States.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Homelayout.dart';
import 'package:movies_app/MainCategory/PersonalProfile/Profile.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Homelayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_app/MainCategory/Settingpage/SettingPage.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';

class CategoryHome extends StatefulWidget {
  static const routeName = "CategoryHome";

  const CategoryHome({super.key});

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight
    ]);
    return BlocProvider(create: (context) =>
    UserCubit()
      ..userInfo(),
        child: BlocConsumer<UserCubit, LoginStates>(
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: Container(
                    decoration: BoxDecoration(
                        image: provider.mode == ThemeMode.light
                            ? DecorationImage(
                            image: AssetImage('assests/images/bg.jpg'),
                            fit: BoxFit.fill)
                            : DecorationImage(
                            image: AssetImage('assests/images/blackbg.jpg'),
                            fit: BoxFit.fill)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search, color: Colors.white, size: 40,),
                              SizedBox(width: 5,),
                              Text(DateTime.now().toString().substring(0, 16),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700
                                ),),
                              Spacer(),
                              ImageIcon(AssetImage('assests/images/movies.png'),
                                size: 45,)
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, MovieHomelayout.routeName, (
                                    route) => false, arguments: Text('movies'));
                              },
                              child: Container(
                                height: 200,
                                width: 170,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, width: 2,),
                                    borderRadius: BorderRadiusDirectional
                                        .circular(12),
                                    image: DecorationImage(image: AssetImage(
                                        "assests/images/moviesCatgory.png"),
                                      fit: BoxFit.cover,)
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.movies,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, SeriesHomelayout.routeName, (
                                    route) => false, arguments: Text('Series'));
                              },
                              child: Container(
                                height: 200,
                                width: 170,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, width: 2,),
                                    borderRadius: BorderRadiusDirectional
                                        .circular(12),
                                    image: DecorationImage(image: AssetImage(
                                        "assests/images/seriesCategory.jpg"),
                                      fit: BoxFit.fill,)
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.series,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              height: 200,
                              width: 170,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white, width: 4,),
                                  borderRadius: BorderRadiusDirectional
                                      .circular(12),
                                  image: DecorationImage(image: AssetImage(
                                      "assests/images/sportsCategory.jpg"),
                                    fit: BoxFit.fill,)
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.sports,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('your subscribtion date : ${UserCubit
                                  .get(context)
                                  .user
                                  .subscribtionDate}', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700)
                              ),
                              Spacer(),
                              IconButton(onPressed: () {
                                Logoutdilog();
                              },
                                  icon: Icon(Icons.power_settings_new_outlined,
                                    color: Colors.white, size: 30,)),
                              SizedBox(width: 12,),
                              IconButton(onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context, SettingPage.routeName,);
                              },
                                icon: Icon(Icons.settings_outlined,
                                    color: Colors.white, size: 30),),
                              SizedBox(width: 12,),
                              Icon(Icons.mic_none_rounded, color: Colors.white,
                                size: 30,),
                              SizedBox(width: 12,),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, Profile.routeName, (
                                      route) => false);
                                },
                                icon: Icon(Icons.person, color: Colors.white,
                                    size: 30),),
                              SizedBox(width: 12,),
                              Icon(Icons.radio, color: Colors.white, size: 30,),
                              SizedBox(width: 20,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            listener: (context, state) {
    if (state is ErrorGetUserData) {
    Text('error');
    } else
    if (state is SucssesGetUserData)
    {} else if (state is LoadingGetUserInformation) {
    CircularProgressIndicator();
    }
    if (state is GetUserInformation) {}
    if (state is LoadingGetUserInformation) {
    showDialog(context: context, builder: (context) {
    return Center(child: CircularProgressIndicator(
    color: Colors.red,
    ));
    },);

    }
            },
  )
  );
}

Logoutdilog() {
  showModalBottomSheet(
    backgroundColor: Colors.transparent, context: context, builder: (context) {
    return BlocProvider(create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(builder: (context, state) {
        return Container(
          height: 170,
          child: Column(
            children: [
              ElevatedButton(onPressed: () {
                FirebaseFunction.Logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.routeName, (route) => false);
                LoginCubit.get(context).autoLogin();
              },
                  child: Center(child: Text('Logout')),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      fixedSize: Size(double.infinity, 70)
                  )),
              SizedBox(height: 5,),
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
              },
                  child: Center(child: Text('Cancel')),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      fixedSize: Size(double.infinity, 70)
                  ))
            ],
          ),
        );
      }, listener: (context, state) {
        if (state is ErrorGetUserData) {
          Text('error');
        } else if (state is SucssesGetUserData) {} else
        if (state is LoadingGetUserInformation) {
          CircularProgressIndicator();
        }
        if (state is GetUserInformation) {}
      },),);
  },);
}}
