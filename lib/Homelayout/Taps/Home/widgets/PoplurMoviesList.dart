import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Homelayout/Taps/Home/Movepage.dart';
import 'package:movies_app/Models/MoviePageModel.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';
import 'package:movies_app/Shared/Network/remote/API_Manger.dart';

class PoplurMoviesList extends StatelessWidget {
  const PoplurMoviesList({super.key});

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
        var Nowplayingmoving = snapshot.data?.results ?? [];
        return Column(
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
                'Now playing',
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
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Movepage.routeName,
                          arguments: MoviePageModel(
                            firebaseId: '',
                            name:
                            Nowplayingmoving[index].originalTitle ?? "",
                            date: Nowplayingmoving[index].releaseDate ?? "",
                            votecount:
                            Nowplayingmoving[index].voteCount ?? 0,
                            rate: Nowplayingmoving[index].voteAverage ?? 0,
                            image: Nowplayingmoving[index].posterPath ?? "",
                            des: Nowplayingmoving[index].overview ?? '',
                            id: Nowplayingmoving[index].id ?? 0,
                            fov: false,
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Stack(
                        children: [
                          Image.network(
                            "${Constant.Image}${Nowplayingmoving[index].posterPath}",
                            filterQuality: FilterQuality.high,
                          ),
                          InkWell(
                            onTap: () {
                              MoviePageModel movie = MoviePageModel(
                                  firebaseId:
                                  FirebaseFunction.getMovieCollection()
                                      .doc()
                                      .id,
                                  name:
                                  Nowplayingmoving[index].originalTitle,
                                  date: Nowplayingmoving[index].releaseDate,
                                  votecount:
                                  Nowplayingmoving[index].voteCount,
                                  rate: Nowplayingmoving[index].voteAverage,
                                  image: Nowplayingmoving[index].posterPath,
                                  des: Nowplayingmoving[index].overview,
                                  id: Nowplayingmoving[index].id,
                                  fov: true);
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
                itemCount: Nowplayingmoving.length,
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
    );
  }
}
