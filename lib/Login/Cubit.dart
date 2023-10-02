import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/MainCategory/CategoryHome.dart';
import 'package:movies_app/Login/States.dart';
import 'package:movies_app/Models/User_model.dart';

import '../Shared/Network/Firebase/FirebaseFunction.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(Logininit());

  static LoginCubit get(context) => BlocProvider.of(context);
  User? firebaseuser = FirebaseAuth.instance.currentUser;
  Future<void> Login(String Email, String Pass, BuildContext context) async {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: Email,
        password: Pass,
      )
          .then(
        (value) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            CategoryHome.routeName,
            (route) => false,
          );
          emit(LoginSucssesState());
        },
      );
    } on FirebaseAuthException catch (error) {
      emit(LoginErrorState(error.toString()));
    }
  }

  autoLogin() {
    firebaseuser = null;
    emit(LoginSucssesState());
  }

}


class UserCubit extends LoginCubit {
  UserCubit() : super();

  static UserCubit get(context) => BlocProvider.of(context);
  UserModel user = UserModel(
      subscribtionDate: '', name: 'name', phoneNum: 0, Email: "Email");
  void userInfo() {
    emit(LoadingGetUserInformation());
        FirebaseFunction.getUserCollection()
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            user = UserModel(
              id: FirebaseAuth.instance.currentUser!.uid,
                subscribtionDate:
                    documentSnapshot.get("subscribtionDate").toString().substring(0,11),
                name: documentSnapshot.get("name").toString(),
                phoneNum: documentSnapshot.get("phoneNum"),
                Email: documentSnapshot.get("Email"));
            emit(GetUserInformation());
          } else {
            print('Document does not exist on the database');
          }
        }).catchError((error){
          emit(ErrorGetUserData(error.toString()));
        });
  }
}


