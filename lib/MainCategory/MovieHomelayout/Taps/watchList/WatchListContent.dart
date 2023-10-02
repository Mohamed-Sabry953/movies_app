import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Cubit/MovieCubit.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/MoviePageModel.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/Movepage.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';

import '../../Cubit/States.dart';

class WatchListContent extends StatelessWidget {
  MoviePageModel moviePageModel;
  int index;

  WatchListContent(this.moviePageModel, this.index);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieHomelayoutCubit, MovieHomeLayoutStates>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            // Navigator.pushNamed(context, Movepage.routeName,
            //     arguments: MoviePageModel(
            //       firebaseId: '',
            //       name: moviePageModel.name ?? "",
            //       date: moviePageModel.date ?? "",
            //       votecount: moviePageModel.votecount ?? 0,
            //       rate: moviePageModel.rate ?? 0,
            //       image: moviePageModel.image ?? "",
            //       des: moviePageModel.des ?? '',
            //       id: moviePageModel.id ?? 0,
            //       fov: false,
            //     ));
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      '${Constant.Image}${moviePageModel.image ?? moviePageModel.image}',
                      fit: BoxFit.fill,
                      width: 170,
                      height: 105,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseFunction.DeleteData(moviePageModel.firebaseId);
                      MovieHomelayoutCubit.get(context).deleteItem(index);
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: 45,
                      height: 40,
                      child: Stack(
                        children: [
                          Icon(
                            Icons.bookmark_outlined,
                            color: Color(0xffF7B539),
                            size: 45,
                            weight: .5,
                          ),
                          Center(
                              child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 18,
                          )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50, top: 25),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: Colors.white54,
                          fixedSize: Size(40, 40),
                          elevation: 0),
                    ),
                  ),
                ]),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(moviePageModel.name ?? '',
                          style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        moviePageModel.date ?? '',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${moviePageModel.des ?? ''}...",
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is GetNowPlayingMovieErrorState) {
          Text('error');
        } else if (state is GetNowPlayingMovieSucssesState) {
        } else if (state is MovieHomeLoadingState) {
          CircularProgressIndicator();
        }
      },
    );
  }
}
