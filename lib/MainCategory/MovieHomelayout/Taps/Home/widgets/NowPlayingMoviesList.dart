import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/widgets/Items/NowPlayingMoviesItem.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Cubit/MovieCubit.dart';
import '../../../Cubit/States.dart';

class NowPlayingMoviesList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (context) => NowPlayingMovieCubit()..NowPlayingMoive(),
      child: BlocConsumer<NowPlayingMovieCubit,MovieHomeLayoutStates>(
        builder: (context, state) {
            return NowPlayingMovieCubit.get(context).NowPlayingMoving.isEmpty?CircularProgressIndicator():
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                    height: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.nowplaying,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                  alignment: AlignmentDirectional.topStart,
                  child: CarouselSlider.builder(
                    itemBuilder: (context, index, realIndex) {
                      return NowPlayingMoviesItem(NowPlayingMovieCubit.get(context).NowPlayingMoving[index], index, NowPlayingMovieCubit.get(context).NowPlayingMoving);
                    },
                    itemCount: NowPlayingMovieCubit.get(context).NowPlayingMoving.length,
                    options: CarouselOptions(
                        height: 160,
                        autoPlay: true,
                        viewportFraction: 0.30,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 100),
                        autoPlayInterval: Duration(seconds: 9)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                    height: 3,
                  ),
                ),
              ],
            );
          },
        listener:(context, state) {
          if(state is GetNowPlayingMovieErrorState){
            Text('error');
          }
          else if(state is GetNowPlayingMovieSucssesState){

          }
          else if(state is MovieHomeLoadingState){
            CircularProgressIndicator();
          }
        } ,
      ),
    );
}}
