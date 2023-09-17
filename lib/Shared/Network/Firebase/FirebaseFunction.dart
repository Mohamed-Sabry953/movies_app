import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/MoviePageModel.dart';
import 'package:movies_app/Models/User_model.dart';

class FirebaseFunction {
  static CollectionReference<MoviePageModel> getMovieCollection() {
    return FirebaseFirestore.instance.collection("Movies").withConverter(
      fromFirestore: (snapshot, _) {
        return MoviePageModel.fromjson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.Tojson();
      },
    );
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance.collection('Users').withConverter(
      fromFirestore: (snapshot, _) {
        return UserModel.fromjson(snapshot.data()!);
      }, toFirestore: (value, _) {
      return value.Tojson();
    },);
  }

  static Future<void> addMovie(MoviePageModel movie) {
    var Collection = getMovieCollection();
    var doc = Collection.doc();
    getMovieCollection().doc();
    movie.firebaseId = doc.id;
    return doc.set(movie);
  }

  static Stream<QuerySnapshot<MoviePageModel>> getMovie() {
    return getMovieCollection().snapshots();
  }

  static Future<void> updateData(String id, MoviePageModel movie) {
    return getMovieCollection().doc(id).update(movie.Tojson());
  }

  static Future<void> DeleteData(String id) {
    return getMovieCollection().doc(id).delete();
  }

  static Future<void> SignUp(String Name, String Email,String Password, int PhoneNum,
      Function Nav) async {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: Email,
          password:Password ).then((userCredential) {
        Nav();
        UserModel userModel = UserModel(
            name: Name, phoneNum:PhoneNum , Email: Email,id: userCredential.user!.uid);
        var Collection= getUserCollection();
        var docRef=Collection.doc(userCredential.user!.uid);
        docRef.set(userModel);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  static Future<void>Login(String Email,String Pass,Function Nav) async {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Email,
          password:Pass,
      ).then((value) {
        Nav();
      },);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
