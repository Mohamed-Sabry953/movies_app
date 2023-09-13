
import 'package:flutter/material.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/widgets/NowPlayingMoviesList.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/widgets/PoplurMoviesList.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/widgets/TopRatedMoviesList.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Taps/Home/widgets/NowPlayingSeriesList.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Taps/Home/widgets/PoplurSeriesList.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Taps/Home/widgets/TopRatedSeriesList.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';
class SeriesHomeTap extends StatefulWidget {
  @override
  State<SeriesHomeTap> createState() => _SeriesHomeTapState();
}

class _SeriesHomeTapState extends State<SeriesHomeTap> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PoplurSeriesList(),
        NowPlayingSeriesList(),
        TopRatedSeriesList(),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
