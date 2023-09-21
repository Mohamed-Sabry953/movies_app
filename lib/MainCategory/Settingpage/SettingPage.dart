import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_app/MainCategory/CategoryHome.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';

import '../../themes/ThemeData.dart';

class SettingPage extends StatefulWidget {
  static const String routeName='Setting';
   SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  String _dropDownValuelang = 'English';

  String _dropDownValueTheming = 'Light';

  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    _dropDownValuelang=provider.language=='en'?'English':'عربى';
    _dropDownValueTheming=provider.mode==ThemeMode.light?'Light':'Dark';
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.setting,style: TextStyle(
          color: Colors.white
        ),),
        toolbarHeight: 70,
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pushNamedAndRemoveUntil(context, CategoryHome.routeName, (route) => false);
        }, icon: Icon(Icons.arrow_back_rounded)),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: provider.mode==ThemeMode.light?DecorationImage(
                image: AssetImage('assests/images/bg.jpg'),
                fit: BoxFit.fill):DecorationImage(
                image: AssetImage('assests/images/blackbg.jpg'),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: TextStyle(
                        color: provider.mode == ThemeMode.light
                            ? MyThemeData.dark
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 40, start: 15, end: 15),
                      padding: EdgeInsetsDirectional.only(start: 15),
                      decoration:
                      BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                      child: DropdownButton(
                        underline: Container(
                          decoration:
                          UnderlineTabIndicator(borderSide: BorderSide.none),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        itemHeight: 60,
                        dropdownColor: Colors.white,
                        hint: _dropDownValuelang == null
                            ? Text(
                          'Dropdown',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        )
                            : Text(
                          _dropDownValuelang,
                          style: TextStyle(color: Colors.blue),
                        ),
                        isExpanded: true,
                        iconSize: 30.0,
                        iconDisabledColor: Colors.black,
                        style: Theme.of(context).textTheme.bodyMedium,
                        items: ['English', AppLocalizations.of(context)!.arabic].map(
                              (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(() {
                            _dropDownValuelang = val!;
                            if (_dropDownValuelang == 'English') {
                              provider.ChangeLanguage('en');
                            } else {
                              provider.ChangeLanguage('ar');
                            }
                            ;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.mode,
                      style: TextStyle(
                        color: provider.mode == ThemeMode.light
                            ? MyThemeData.dark
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 40, start: 15, end: 15),
                      padding: EdgeInsetsDirectional.only(start: 15),
                      decoration:
                      BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                      child: DropdownButton(
                        underline: Container(
                          decoration:
                          UnderlineTabIndicator(borderSide: BorderSide.none),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        itemHeight: 60,
                        dropdownColor: Colors.white,
                        hint: _dropDownValueTheming == null
                            ? Text(
                          'Dropdown',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        )
                            : Text(
                          _dropDownValueTheming,
                          style: TextStyle(color: Colors.blue),
                        ),
                        isExpanded: true,
                        iconSize: 30.0,
                        iconDisabledColor: Colors.black,
                        style: Theme.of(context).textTheme.bodyMedium,
                        items: ['Light', 'Dark'].map(
                              (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                                () {
                              _dropDownValueTheming = val!;
                              if (_dropDownValueTheming == 'Light') {
                                provider.changetheme(ThemeMode.light);
                              } else {
                                provider.changetheme(ThemeMode.dark);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
