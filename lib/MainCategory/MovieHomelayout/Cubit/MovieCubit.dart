import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/HomeScreenModels/Top_rate_movies_model.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/MoviePageModel.dart';

import '../../../Shared/Constant/constant.dart';
import '../../../Shared/Network/Firebase/FirebaseFunction.dart';
import '../../SeriesHomeLayout/Taps/Home/seriespage.dart';
import '../Models/HomeScreenModels/Now_playing_movies.dart';
import 'States.dart';
import 'package:http/http.dart' as http;

class MovieHomelayoutCubit extends Cubit<MovieHomeLayoutStates> {
  MovieHomelayoutCubit() : super(MovieHomeinit());

  static MovieHomelayoutCubit get(context) => BlocProvider.of(context);
  List<MoviePageModel>getData=[];

  toMoviePage2(BuildContext context, index,
      List<TopRatedResults> TopRatedMoving) {
    Navigator.pushNamed(context, Movepage.routeName,
        arguments: MoviePageModel(
          firebaseId: '',
          name: TopRatedMoving[index].name ?? "",
          date: TopRatedMoving[index].firstAirDate ?? "",
          votecount: TopRatedMoving[index].voteCount ?? 0,
          rate: TopRatedMoving[index].voteAverage ?? 0,
          image: TopRatedMoving[index].posterPath ?? "",
          des: TopRatedMoving[index].overview ?? '',
          id: TopRatedMoving[index].id ?? 0,
          fov: false,
        ));
  }

  void data() {
    FirebaseFunction.getMovieCollection()
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        FirebaseFunction.getMovieCollection()
            .doc(doc["firebaseId"])
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            MoviePageModel movies = MoviePageModel(name: documentSnapshot.get("name",).toString(),
                date: documentSnapshot.get("date",).toString(),
                votecount: documentSnapshot.get("votecount",),
                rate: documentSnapshot.get("rate",),
                image: documentSnapshot.get("image",).toString(),
                des: documentSnapshot.get("des",).toString(),
                id: documentSnapshot.get("id",),
                firebaseId: documentSnapshot.get("firebaseId",).toString(),
                fov: documentSnapshot.get("fov",));
            getData.add(movies);
            emit(GetNowPlayingMovieSucssesState());
          } else {
            print('Document does not exist on the database');
          }
        });
      });
    });
  }
  deleteItem(int index){
    getData.removeAt(index);
    emit(GetNowPlayingMovieSucssesState());
  }
}
class NowPlayingMovieCubit extends MovieHomelayoutCubit {
  NowPlayingMovieCubit() : super();

  static NowPlayingMovieCubit get(context) => BlocProvider.of(context);
  List<Results> NowPlayingMoving = [];
  List<Results> PoplurMovies = [];

  void NowPlayingMoive() {
    Uri url = Uri.https("api.themoviedb.org", "/3/trending/movie/day",
        {"api_key": Constant.API_KEY});
    http.get(url).then((response) {
      emit(MovieHomeLoadingState());
      var jsondata = jsonDecode(response.body);
      Movies movies = Movies.fromJson(jsondata);
      NowPlayingMoving = movies.results ?? [];
    }).catchError((error) {
      emit(GetNowPlayingMovieErrorState(error.toString()));
    });
  }
  void PoplurMoive() {
    Uri url = Uri.https("api.themoviedb.org", "/3/trending/movie/day",
        {"api_key": Constant.API_KEY});
    http.get(url).then((response) {
      emit(MovieHomeLoadingState());
      var jsondata = jsonDecode(response.body);
      Movies movies = Movies.fromJson(jsondata);
      PoplurMovies = movies.results ?? [];
      emit(GetPoplurMoviesSucssesState());
    }).catchError((error) {
      emit(GetNowPlayingMovieErrorState(error.toString()));
    });
  }
  toMoviePage(BuildContext context, index, List<Results> Nowplayingmoving) {
    Navigator.pushNamed(context, Movepage.routeName,
        arguments: MoviePageModel(
          firebaseId: '',
          name: Nowplayingmoving[index].originalTitle ?? "",
          date: Nowplayingmoving[index].releaseDate ?? "",
          votecount: Nowplayingmoving[index].voteCount ?? 0,
          rate: Nowplayingmoving[index].voteAverage ?? 0,
          image: Nowplayingmoving[index].posterPath ?? "",
          des: Nowplayingmoving[index].overview ?? '',
          id: Nowplayingmoving[index].id ?? 0,
          fov: false,
        ));
  }
  toFirebase(BuildContext context, index, List<Results> NowPlayingMoving) {
    MoviePageModel movie = MoviePageModel(
        firebaseId: FirebaseFunction
            .getMovieCollection()
            .doc()
            .id,
        name: NowPlayingMoving[index].originalTitle,
        date: NowPlayingMoving[index].releaseDate,
        votecount: NowPlayingMoving[index].voteCount,
        rate: NowPlayingMoving[index].voteAverage,
        image: NowPlayingMoving[index].posterPath,
        des: NowPlayingMoving[index].overview,
        id: NowPlayingMoving[index].id,
        fov: true);
    FirebaseFunction.addMovie(movie);
  }
}
class TopRatedMovieCubit extends MovieHomelayoutCubit {
  TopRatedMovieCubit() : super();

  static TopRatedMovieCubit get(context) => BlocProvider.of(context);
  List<TopRatedResults>TopRatedMovies=[];
  Future<Movies>? topRatedMovies() {
    Uri url = Uri.https("api.themoviedb.org", "/3/tv/top_rated",
        {"api_key": Constant.API_KEY});
    http.get(url).then((response) {
      emit(MovieHomeLoadingState());
      var jsondata = jsonDecode(response.body);
      TopRateMoviesModel movies = TopRateMoviesModel.fromJson(jsondata);
      TopRatedMovies = movies.results ?? [];
      emit(GetTopRateMovieSucssesState());
    }).catchError((error) {
      emit(GetTopRateMovieErrorState(error.toString()));
    });
  }

}

