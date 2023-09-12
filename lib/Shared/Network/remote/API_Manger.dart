

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/Models/CategoryScreenModels/CategoryModel.dart';
import 'package:movies_app/Models/CategoryScreenModels/CatgoryMovieModel.dart';
import 'package:movies_app/Models/HomeScreenModels/Now_playing_movies.dart';
import 'package:movies_app/Models/HomeScreenModels/PoplurMovies.dart';
import 'package:movies_app/Models/SamularMovieModel/SamularMovieModel.dart';
import 'package:movies_app/Models/SearchScreenModel/SearchModel.dart';
import 'package:movies_app/Models/HomeScreenModels/Top_rate_movies_model.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
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
  static Future<SearchModel>Search(String q)async{
    Uri url=Uri.https("api.themoviedb.org","/3/search/movie",{
      "api_key":Constant.API_KEY,"query":q
    });
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
      SearchModel searchModel=SearchModel.fromJson(jsondata);
    return searchModel;
  }
  static Future<CategoryModel>Category()async{
    Uri url=Uri.https("api.themoviedb.org","/3/genre/movie/list",{
      "api_key":Constant.API_KEY
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
}