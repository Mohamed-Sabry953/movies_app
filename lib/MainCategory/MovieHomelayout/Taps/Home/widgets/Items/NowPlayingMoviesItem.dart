import 'package:flutter/material.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/HomeScreenModels/Now_playing_movies.dart';

import '../../../../../../Shared/Constant/constant.dart';
import '../../../../Cubit/MovieCubit.dart';
import '../../../../Models/MoviePageModel.dart';

class NowPlayingMoviesItem extends StatefulWidget {
  Results results;
  int index;
  List<Results>NowPlayingMovies;


  NowPlayingMoviesItem(this.results,this.index,this.NowPlayingMovies);

  @override
  State<NowPlayingMoviesItem> createState() => _NowPlayingMoviesItemState();
}

class _NowPlayingMoviesItemState extends State<NowPlayingMoviesItem> {
  @override
  Widget build(BuildContext context) {
return InkWell(
    onTap: () {
      NowPlayingMovieCubit.get(context).toMoviePage(context, widget.index, widget.NowPlayingMovies);
    },
    child: Container(
      decoration: BoxDecoration(color: Colors.grey),
      child: Stack(
        children: [
          Image.network(
            "${Constant.Image}${widget.results.posterPath}",
            filterQuality: FilterQuality.high,
          ),
          InkWell(
            onTap: () {
              NowPlayingMovieCubit.get(context).toFirebase(context, widget.index, widget.NowPlayingMovies);
              NowPlayingMovieCubit.get(context).data();
              setState(() {
              });
            },
            child: Container(
              width: 40,
              height: 40,
              child: Stack(
                children: [
                  Icon(
                    Icons.bookmark_outlined,
                    color:Color(0xff514F4F),
                    size: 40,
                    weight: .5,
                  ),
                  Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}}