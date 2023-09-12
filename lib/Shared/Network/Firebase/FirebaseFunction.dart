import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/Models/MoviePageModel.dart';

class FirebaseFunction {
  static CollectionReference<MoviePageModel>getMovieCollection() {
    return FirebaseFirestore.instance.collection("Movies").withConverter(
      fromFirestore: (snapshot, _) {
    return MoviePageModel.fromjson(snapshot.data()!);
      }, toFirestore: (value, _) {
        return value.Tojson();
    },);
  }
  static Future<void>addMovie(MoviePageModel movie){
    var Collection=getMovieCollection();
    var doc=Collection.doc();
    getMovieCollection().doc();
    movie.firebaseId=doc.id;
    return doc.set(movie);
  }
  static Stream<QuerySnapshot<MoviePageModel>> getMovie(){
    return getMovieCollection().snapshots();
  }
  static Future<void>updateData(String id,MoviePageModel movie){
    return getMovieCollection().doc(id).update(movie.Tojson());
  }
  static Future<void>DeleteData(String id){
    return getMovieCollection().doc(id).delete();
  }
}