import 'package:flutter/material.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/MoviePageModel.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';
import 'package:movies_app/Shared/Network/remote/API_Manger.dart';
import '../Home/seriespage.dart';

class SeriesCategory extends StatelessWidget {
  static const String routeName = "SeriesByCategory";

  const SeriesCategory({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as MoviePageModel;
    return Scaffold(
      backgroundColor: Color(0xff121312),
      appBar: AppBar(
         backgroundColor: Color(0xff121312),
        centerTitle: true,
        title: Text(args.name??'',style:  TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),),
      ),
      body: FutureBuilder(
        future: API_Manager.PoplurSeries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snapshot.hasError) {
            return Center(child: Text('something went error'));
          }
          var CategoryMoves = snapshot.data?.results ?? [];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: CategoryMoves.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: Divider(
                            thickness: 1.5,
                            endIndent: 15,
                            color: Colors.white,
                          ),
                        );
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Movepage.routeName,
                                arguments: MoviePageModel(
                                  firebaseId: '',
                                  name: CategoryMoves[index].name ??
                                      "",
                                  date:
                                      CategoryMoves[index].firstAirDate ?? "",
                                  votecount:
                                      CategoryMoves[index].voteCount ?? 0,
                                  rate: CategoryMoves[index].voteAverage ?? 0,
                                  image:
                                      CategoryMoves[index].posterPath ?? "",
                                  des: CategoryMoves[index].overview ?? '',
                                  id: CategoryMoves[index].id ?? 0,
                                  fov: false,
                                ));
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
                                      '${Constant.Image}${CategoryMoves[index].posterPath ?? CategoryMoves[index].posterPath}',
                                      fit: BoxFit.fill,
                                      width: 170,
                                      height: 105,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      FirebaseFunction.addMovie(MoviePageModel(
                                          firebaseId: FirebaseFunction
                                                  .getMovieCollection()
                                              .doc()
                                              .id,
                                          name: CategoryMoves[index]
                                              .name,
                                          date: CategoryMoves[index]
                                              .firstAirDate,
                                          votecount:
                                              CategoryMoves[index].voteCount,
                                          rate: CategoryMoves[index]
                                              .voteAverage,
                                          image:
                                              CategoryMoves[index].posterPath,
                                          des: CategoryMoves[index].overview,
                                          id: CategoryMoves[index].id,
                                          fov: true));
                                    },
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      width: 45,
                                      height: 40,
                                      child: Stack(
                                        children: [
                                          Icon(
                                            Icons.bookmark_outlined,
                                            color: Color(0xff514F4F),
                                            size: 45,
                                            weight: .5,
                                          ),
                                          Center(
                                              child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 18,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 50, top: 25),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          CategoryMoves[index]
                                                  .name ??
                                              '',
                                          style: TextStyle(
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18)),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        CategoryMoves[index].firstAirDate ??
                                            '',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "${CategoryMoves[index].overview ?? ''}...",
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
                    ),
                  ),
                ]),
          );
        },
      ),
    );
  }
}
