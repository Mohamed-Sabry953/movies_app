abstract class MovieHomeLayoutStates{}

class MovieHomeinit extends MovieHomeLayoutStates{}
class MovieHomeLoadingState extends MovieHomeLayoutStates{}
//Now playing States
class GetNowPlayingMovieSucssesState extends MovieHomeLayoutStates{}
class GetNowPlayingMovieErrorState extends MovieHomeLayoutStates {
  String Error;

  GetNowPlayingMovieErrorState(this.Error);
}
class GetPoplurMoviesSucssesState extends MovieHomeLayoutStates{}
class GetPoplurMoviesMovieErrorState extends MovieHomeLayoutStates {
  String Error;

  GetPoplurMoviesMovieErrorState(this.Error);
}
//Top Rated States
class GetTopRateMovieSucssesState extends MovieHomeLayoutStates{}
class GetTopRateMovieErrorState extends MovieHomeLayoutStates {
  String error;
  GetTopRateMovieErrorState(this.error);
}
//Search Tap States
class GetSearchDataSucsses extends MovieHomeLayoutStates{}
class GetSearchDataError extends MovieHomeLayoutStates {
  String error;

  GetSearchDataError(this.error);
}
