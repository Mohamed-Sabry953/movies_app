import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/Signup/SignUp.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';
import '../MainCategory/CategoryHome.dart';
import '../Shared/Network/Firebase/FirebaseFunction.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'Login';

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formkey = GlobalKey<FormState>();

  final TextEditingController pass = TextEditingController();

  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: provider.mode==ThemeMode.light?DecorationImage(
                image: AssetImage('assests/images/bg.jpg'),
                fit: BoxFit.fill):DecorationImage(
                image: AssetImage('assests/images/blackbg.jpg'),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: formkey,
                  child: Column(
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: Image.asset(
                            'assests/images/movies.png',
                            width: 200,
                            height: 150,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xff121312),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, right: 8, left: 8),
                          child: TextFormField(
                            controller: pass,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 30, left: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseFunction.Login(email.text, pass.text, () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  CategoryHome.routeName, (route) => false,);
                            },).catchError((e) {

                            });
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              fixedSize: Size(10000, 50)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Create new account ?',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w700)),
                          SizedBox(
                            width: 2,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  SignUpPage.routeName, (route) => false);
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
