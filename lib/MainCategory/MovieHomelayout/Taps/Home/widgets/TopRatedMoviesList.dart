import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Cubit/MovieCubit.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Cubit/States.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/MoviePageModel.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';
import 'package:movies_app/Shared/Network/remote/API_Manger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopRatedMoviesList extends StatelessWidget {
  const TopRatedMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TopRatedMovieCubit()..topRatedMovies(),
        child: BlocConsumer<TopRatedMovieCubit, MovieHomeLayoutStates>(
          builder: (context, state) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.toprate,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 10,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              MovieHomelayoutCubit.get(context).toMoviePage2(context, index, TopRatedMovieCubit.get(context).TopRatedMovies);
                            },
                            child: Container(
                              width: 110,
                              decoration: BoxDecoration(color: Color(0xff1A1A1A)),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "${Constant.Image}${TopRatedMovieCubit.get(context).TopRatedMovies[index].posterPath}",
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    width: 110,
                                  ),
                                  InkWell(
                                    onTap: () {
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      child: Stack(
                                        children: [
                                          Icon(
                                            Icons.bookmark_outlined,
                                            color: Color(0xff514F4F),
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
                        },
                        itemCount: TopRatedMovieCubit.get(context).TopRatedMovies.length,
                      ),
                    ),
                  ],
                ),
              ),
            ) ;
          },
          listener: (context, state) {
            if(state is GetTopRateMovieErrorState){
              Text('error');
            }
            else if(state is GetTopRateMovieSucssesState){
            }
            else if(state is MovieHomeLoadingState){
              CircularProgressIndicator();
            }
          },
        ));
  }
}
