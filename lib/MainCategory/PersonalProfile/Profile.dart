import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Login/Cubit.dart';
import 'package:movies_app/Login/States.dart';
import 'package:provider/provider.dart';
import '../../provider/Myprovider.dart';
import '../CategoryHome.dart';

class Profile extends StatelessWidget {
  static const String routeName = 'Profile';

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return BlocProvider(
      create: (context) => UserCubit()..userInfo(),
      child: BlocConsumer<UserCubit, LoginStates>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Profile",
                  style: TextStyle(color: Colors.white),
                ),
                toolbarHeight: 70,
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, CategoryHome.routeName, (route) => false);
                    },
                    icon: Icon(Icons.arrow_back_rounded)),
              ),
              body: Container(
                decoration: BoxDecoration(
                    image: provider.mode == ThemeMode.light
                        ? DecorationImage(
                            image: AssetImage('assests/images/bg.jpg'),
                            fit: BoxFit.fill)
                        : DecorationImage(
                            image: AssetImage('assests/images/blackbg.jpg'),
                            fit: BoxFit.fill)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.all(8),
                        margin: EdgeInsetsDirectional.only(bottom: 15),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image(image: AssetImage("assests/images/Profile.jpg"),width: 250,height: 150,fit: BoxFit.fill,)),
                      ),
                      Divider(thickness: 2,color: Colors.amber,endIndent: 30,indent: 30,),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Name : ',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              width: 256,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  UserCubit.get(context).user.name,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Email : ',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              width: 256,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  UserCubit.get(context).user.Email,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Your id : ',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              width: 256,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  UserCubit.get(context).user.id,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Your Sub\n    Date : ',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  UserCubit.get(context).user.subscribtionDate,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
        listener: (context, state) {
          if (state is ErrorGetUserData) {
            Text('error');
          } else if (state is SucssesGetUserData) {
          } else if (state is LoadingGetUserInformation) {
            CircularProgressIndicator();
          }
          if (state is GetUserInformation) {}
        },
      ),
    );
  }
}
