import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/Login/LoginPage.dart';
import 'package:movies_app/MainCategory/CategoryHome.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = 'SignUp';
  var formkey = GlobalKey<FormState>();
  final TextEditingController pass = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController Phone = TextEditingController();
  final TextEditingController Name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assests/images/bg.jpg',
                ),
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
                            controller: Name,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: email,
                            validator: validateEmail,
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
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: Phone,
                            validator: validateMobile,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'phone number',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, right: 8, left: 8),
                          child: TextFormField(
                            controller: pass,
                            validator: validatePassword,
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
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: validateConfirmPassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'confirm password ',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8.0, right: 30, left: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              FirebaseFunction.SignUp(
                                  Name.text,
                                  email.text,
                                  pass.text,
                                  int.parse(Phone.text),
                                  () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    CategoryHome.routeName, (route) => false);
                              }).catchError((e) {
                                print('error');
                              });
                            }
                          },
                          child: Text(
                            'Sign in',
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
                          Text('Have you account ?',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w700)),
                          SizedBox(
                            width: 2,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  LoginPage.routeName, (route) => false);
                            },
                            child: Text(
                              'Login',
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

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 &&
          value.contains('@') &&
          value.endsWith('gmail.com')) {
        return null;
      }
      return 'Enter a Valid Email Address';
    }
  }

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) return 'Empty';
    if (value != pass.text) {
      return 'Not Match';
    }
    return null;
  }

  String? validateMobile(String? value) {
// Indian Mobile number are of 10 digit only
    if (value!.length != 11)
      return 'Mobile Number must be of 10 digit';
    else {
      return null;
    }
  }
}
