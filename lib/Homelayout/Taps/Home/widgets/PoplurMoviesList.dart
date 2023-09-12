import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Models/MoviePageModel.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';
import 'package:movies_app/Shared/Network/remote/API_Manger.dart';

import '../Movepage.dart';

class PoplurMoviesList extends StatelessWidget {
  PoplurMoviesList( {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: API_Manager.NowPlayingMoive(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        if (snapshot.hasError) {
          return Center(child: Text('something went error'));
        }
        var PoplurMovies = snapshot.data?.results ?? [];
        return Container(
          alignment: AlignmentDirectional.topStart,
          child: CarouselSlider.builder(
            itemBuilder: (context, index, realIndex) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Movepage.routeName,
                      arguments: MoviePageModel(
                        firebaseId: '',
                        name: PoplurMovies[index].originalTitle ?? "",
                        date: PoplurMovies[index].releaseDate ?? "",
                        votecount: PoplurMovies[index].voteCount ?? 0,
                        rate: PoplurMovies[index].voteAverage ?? 0,
                        image: PoplurMovies[index].posterPath ?? "",
                        des: PoplurMovies[index].overview ?? '',
                        id: PoplurMovies[index].id ?? 0,
                        fov: false,
                      ));
                },
                child: Container(
                  padding: EdgeInsetsDirectional.all(5),
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 250,
                  child: Stack(children: [
                    Image.network(
                      '${Constant.Image}${PoplurMovies[index].posterPath}',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 150,
                      filterQuality: FilterQuality.high,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50, left: 10),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${Constant.Image}${PoplurMovies[index].posterPath}",
                                  filterQuality: FilterQuality.high,
                                ),
                                InkWell(
                                  onTap: () {
                                    MoviePageModel movie = MoviePageModel(
                                        firebaseId: FirebaseFunction
                                            .getMovieCollection()
                                            .doc()
                                            .id,
                                        name: PoplurMovies[index]
                                            .originalTitle,
                                        date:
                                        PoplurMovies[index].releaseDate,
                                        votecount:
                                        PoplurMovies[index].voteCount,
                                        rate:
                                        PoplurMovies[index].voteAverage,
                                        image:
                                        PoplurMovies[index].posterPath,
                                        des: PoplurMovies[index].overview,
                                        id: PoplurMovies[index].id,
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
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${PoplurMovies[index].originalTitle}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.yellowAccent),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${PoplurMovies[index].releaseDate}",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 50, right: 10),
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Center(
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                            size: 33,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            backgroundColor: Colors.white54,
                            fixedSize: Size(60, 60),
                            elevation: 0),
                      ),
                    ),
                  ]),
                ),
              );
            },
            itemCount: PoplurMovies.length,
            options: CarouselOptions(
              autoPlayInterval: Duration(seconds: 9),
              viewportFraction: 1,
              height: 220,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(milliseconds: 100),
            ),
          ),
        );
      },
    );
  }
}
