

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/MainCategory/MovieHomelayout/Models/CategoryScreenModels/CategoryModel.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/CategoryScreenModels/CatgoryMovieModel.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/HomeScreenModels/Now_playing_movies.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/HomeScreenModels/PoplurMovies.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/HomeScreenModels/Top_rate_movies_model.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/SamularMovieModel/SamularMovieModel.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/SearchScreenModel/SearchModel.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Models/CategoryScreenModels/CategoryModel2.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Models/HomeScreenModels/PoplurSeriesModel.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Models/HomeScreenModels/TopRatedSeriesModel.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Models/SearchScreenModel/SearchSeriesModel.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
import 'package:provider/provider.dart';
class API_Manager{
  static Future<TopRateMoviesModel>TopRatedMoive()async{
    Uri url=Uri.https("api.themoviedb.org","/3/tv/top_rated",{
      "api_key":Constant.API_KEY
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
    TopRateMoviesModel topRateMoviesModel=TopRateMoviesModel.fromJson(jsondata);
    return topRateMoviesModel;
  }
  static Future<Movies>NowPlayingMoive()async{
    Uri url=Uri.https("api.themoviedb.org","/3/trending/movie/day",{
      "api_key":Constant.API_KEY
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
      Movies movies=Movies.fromJson(jsondata);
    return movies;
  }
  static Future<PoplurMovies>PoplurMovie()async{
    Uri url=Uri.https("api.themoviedb.org","/3/movie/popular",{
      "api_key":Constant.API_KEY
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
      PoplurMovies poplurMovies=PoplurMovies.fromJson(jsondata);
    return poplurMovies;
  }
  static Future<SamularMovieModel>SamularMovie(int id)async{
    Uri url=Uri.https("api.themoviedb.org","/3/movie/$id/similar",{
      "api_key":Constant.API_KEY
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
      SamularMovieModel samularMovieModel=SamularMovieModel.fromJson(jsondata);
    return samularMovieModel;
  }
  static Future<SearchModel>SearchMovie(String q)async{
    Uri url=Uri.https("api.themoviedb.org","/3/search/movie",{
      "api_key":Constant.API_KEY,"query":q
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
      SearchModel searchModel=SearchModel.fromJson(jsondata);
    return searchModel;
  }
  static Future<CategoryModel>Category(String lang)async{
    Uri url=Uri.https("api.themoviedb.org","/3/genre/movie/list",{
      "api_key":Constant.API_KEY,"language":lang
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
      CategoryModel categoryModel=CategoryModel.fromJson(jsondata);
    return categoryModel;
  }
  static Future<CatgoryMovieModel>CategoryMovie()async{
    Uri url=Uri.https("api.themoviedb.org","/3/discover/movie",{
      "api_key":Constant.API_KEY
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
      CatgoryMovieModel catgoryMovieModel=CatgoryMovieModel.fromJson(jsondata);
    return catgoryMovieModel;
  }
  static Future<TopRatedSeriesModel>TopRatedSeries()async{
    Uri url=Uri.https("api.themoviedb.org","/3/tv/top_rated",{
      "api_key":Constant.API_KEY
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
    TopRatedSeriesModel topRatedSeriesModel=TopRatedSeriesModel.fromJson(jsondata);
    return topRatedSeriesModel;
  }
  static Future<SearchSeriesModel>PoplurSeries()async{
    Uri url=Uri.https("api.themoviedb.org","/3/search/tv",{
      "api_key":Constant.API_KEY,"query":"s"
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
    SearchSeriesModel popularSeriesModel=SearchSeriesModel.fromJson(jsondata);
    return popularSeriesModel;
  }
  static Future<CategoryModel2>Category2(String lang)async{
    Uri url=Uri.https("api.themoviedb.org","/3/genre/tv/list",{
      "api_key":Constant.API_KEY,"language":lang
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
    CategoryModel2 categoryModel2=CategoryModel2.fromJson(jsondata);
    return categoryModel2;
  }
  static Future<CatgoryMovieModel>CategorySeries()async{
    Uri url=Uri.https("api.themoviedb.org","/3/discover/tv",{
      "api_key":Constant.API_KEY
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
    CatgoryMovieModel catgoryMovieModel=CatgoryMovieModel.fromJson(jsondata);
    return catgoryMovieModel;
  }
  static Future<SearchSeriesModel>SearchSeries(String q)async{
    Uri url=Uri.https("api.themoviedb.org","/3/search/tv",{
      "api_key":Constant.API_KEY,"query":q
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
    SearchSeriesModel searchModel=SearchSeriesModel.fromJson(jsondata);
    return searchModel;
  }
}