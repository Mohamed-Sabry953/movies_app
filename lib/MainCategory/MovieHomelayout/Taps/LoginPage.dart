import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = 'Login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff121312),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image(
              image: AssetImage('assests/images/movies.png'),
              width: 200,
              height: 150,
            )),
            TextFormField(

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none
                ),
                fillColor: Colors.white
              ),
            ),
            SizedBox(height: 30,),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
