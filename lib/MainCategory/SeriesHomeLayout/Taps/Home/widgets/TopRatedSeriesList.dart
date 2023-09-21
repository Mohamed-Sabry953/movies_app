import 'package:flutter/material.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/MoviePageModel.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/Movepage.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';
import 'package:movies_app/Shared/Network/remote/API_Manger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopRatedSeriesList extends StatelessWidget {
  const TopRatedSeriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: API_Manager.TopRatedSeries(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('something went error'));
        }
        var TopRateMove = snapshot.data?.results ?? [];
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
                          Navigator.pushNamed(context, Movepage.routeName,
                              arguments: MoviePageModel(
                                firebaseId: '',
                                name: TopRateMove[index].name ?? "",
                                date: TopRateMove[index].firstAirDate ?? "",
                                votecount:
                                TopRateMove[index].voteCount ?? 0,
                                rate: TopRateMove[index].voteAverage ?? 0,
                                image: TopRateMove[index].posterPath ?? "",
                                des: TopRateMove[index].overview ?? '',
                                id: TopRateMove[index].id ?? 0,
                                fov: false,
                              ));
                        },
                        child: Container(
                          width: 110,
                          decoration:
                          BoxDecoration(color: Color(0xff1A1A1A)),
                          child: Stack(
                            children: [
                              Image.network(
                                "${Constant.Image}${TopRateMove[index].posterPath}",
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                                width: 110,
                              ),
                              InkWell(
                                onTap: () {
                                  MoviePageModel movie = MoviePageModel(
                                      firebaseId: FirebaseFunction
                                          .getMovieCollection()
                                          .doc()
                                          .id,
                                      name: TopRateMove[index].name,
                                      date: TopRateMove[index].firstAirDate,
                                      votecount:
                                      TopRateMove[index].voteCount,
                                      rate: TopRateMove[index].voteAverage,
                                      image: TopRateMove[index].posterPath,
                                      des: TopRateMove[index].overview,
                                      id: TopRateMove[index].id,
                                      fov: false);
                                  FirebaseFunction.addMovie(movie);
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
                    itemCount: TopRateMove.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
