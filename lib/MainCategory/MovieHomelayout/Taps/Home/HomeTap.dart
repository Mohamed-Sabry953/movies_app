
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Cubit/MovieCubit.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/widgets/NowPlayingMoviesList.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/widgets/PoplurMoviesList.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/widgets/TopRatedMoviesList.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';

import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';
class HomeTap extends StatefulWidget {
  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return BlocProvider(create: (context) => MovieHomelayoutCubit(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PoplurMoviesList(),
        NowPlayingMoviesList(),
        TopRatedMoviesList(),
        SizedBox(
          height: 5,
        )
      ],
    ),);
  }
}
